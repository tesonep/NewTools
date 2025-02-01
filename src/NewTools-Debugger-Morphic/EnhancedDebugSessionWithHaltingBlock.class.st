Class {
	#name : 'EnhancedDebugSessionWithHaltingBlock',
	#superclass : 'StMorphicDebugSession',
	#instVars : [
		'originalBlocks',
		'newBlocks'
	],
	#category : 'NewTools-Debugger-Morphic-Core',
	#package : 'NewTools-Debugger-Morphic',
	#tag : 'Core'
}

{ #category : 'menu - operations' }
EnhancedDebugSessionWithHaltingBlock >> findNextContext: aContext [ 
	
	| callingContext idx haltingBlock newContext |
	
	originalBlocks ifEmpty: [ ^ aContext ].
	
	(aContext receiver isKindOf: Halt) ifFalse: [ ^ aContext ].

	callingContext := aContext.
	[ callingContext method = (HaltingBlock >> #haltIfStepping)  ] whileFalse: [ callingContext := callingContext sender ].

	haltingBlock := callingContext receiver.
	[ callingContext receiver class = HaltingBlock  ] whileTrue: [ callingContext := callingContext sender ].
	
	newContext := haltingBlock originalBlock asContextWithSender: callingContext.
	newContext stepToSendOrReturn.

	^ newContext
]

{ #category : 'initialization' }
EnhancedDebugSessionWithHaltingBlock >> initialize [ 
	
	super initialize.
	originalBlocks := OrderedCollection new.
	newBlocks := OrderedCollection new.
]

{ #category : 'preparation' }
EnhancedDebugSessionWithHaltingBlock >> prepareContextForStepThrough: aContext [ 
	
	| maybeABlock |
	1 to: aContext size do: [ :idx | 
		self updateFullBlocksOf: aContext withIndex: idx ].
	
	aContext receiver class allSlots do: [ :aSlot | 
		maybeABlock := aSlot read: aContext receiver.
		maybeABlock isBlock 
			ifTrue: [ self updateFullBlockOfReceiver: aContext receiver block: maybeABlock slot: aSlot ] ]
]

{ #category : 'clean-up' }
EnhancedDebugSessionWithHaltingBlock >> revertBlocks [

	newBlocks asArray elementsForwardIdentityTo: originalBlocks asArray.
	
]

{ #category : 'debugging actions' }
EnhancedDebugSessionWithHaltingBlock >> stepThrough: aContext [
	"Send messages until you return to selectedContext.
	 Used to step into a block in the method."

	| newContext |

	aContext stepIntoQuickMethod: false.
	(self isContextPostMortem: aContext) ifTrue: [^ self].
	
	self prepareContextForStepThrough: aContext.
	
	interruptedProcess psValueAt: (DebuggerSteppingState soleInstance index) put: true.
	newContext := interruptedProcess completeStep: aContext.
	interruptedProcess psValueAt: (DebuggerSteppingState soleInstance index) put: false.

	newContext := self findNextContext: newContext.

	self revertBlocks.

	self updateContextTo:
		(newContext == aContext
			ifTrue: [ (self stepToFirstInterestingBytecodeIn: interruptedProcess) ]
			ifFalse: [ newContext ]).

	self triggerEvent: #stepThrough
]

{ #category : 'preparation' }
EnhancedDebugSessionWithHaltingBlock >> transformBlock: originalBlock [

	| blockIndex newBlock |
	(blockIndex := originalBlocks indexOf: originalBlock) > 0
		ifTrue: [ 
			^ (newBlocks at: blockIndex). ].
	
	newBlock := HaltingBlock new 
		originalBlock: originalBlock;
		yourself.
			
	originalBlocks add: originalBlock.
	newBlocks add: newBlock.

	^ newBlock	
]

{ #category : 'as yet unclassified' }
EnhancedDebugSessionWithHaltingBlock >> updateFullBlockOfReceiver: aReceiver block: originalBlock slot: aSlot [ 
	
	aSlot write: (self transformBlock: originalBlock) to: aReceiver.
]

{ #category : 'preparation' }
EnhancedDebugSessionWithHaltingBlock >> updateFullBlocksOf: aContext withIndex: anIndex [ 
	
	| originalBlock |
	
	originalBlock := aContext at: anIndex.
	originalBlock isBlock ifFalse: [ ^ self ].
	
	aContext at: anIndex put: (self transformBlock: originalBlock).
]
