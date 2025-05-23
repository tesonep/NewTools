"
I am an inspector dedicated to the debugger.
I wrap a StInspector object which provides inspection views for the inspected object.
I add specific debugger functionalities:
- I remember selection in the inspector list depending on the context
- I dynamically change my layout depending on the context (e.g., I show a diff view in case of an assertion failure)
"
Class {
	#name : 'StDebuggerInspector',
	#superclass : 'SpPresenter',
	#instVars : [
		'inspector',
		'model',
		'label',
		'rawInspectionSelectionCache',
		'assertionFailure',
		'lateralToolbar',
		'currentLayoutSelector',
		'shouldBeUpdated'
	],
	#classInstVars : [
		'maximizeAssertionSpec'
	],
	#category : 'NewTools-Debugger-View',
	#package : 'NewTools-Debugger',
	#tag : 'View'
}

{ #category : 'specs' }
StDebuggerInspector class >> maximizeAssertionSpec [
	^maximizeAssertionSpec ifNil:[maximizeAssertionSpec := false]
]

{ #category : 'specs' }
StDebuggerInspector class >> maximizeAssertionSpec: aboolean [
	maximizeAssertionSpec := aboolean
]

{ #category : 'instance creation' }
StDebuggerInspector class >> openOn: anObject [

	^ (self on: (StInspectorModel on: anObject)) open
]

{ #category : 'specs' }
StDebuggerInspector class >> toggleMaximizeAssertionSpec [
	self maximizeAssertionSpec: self maximizeAssertionSpec not
]

{ #category : 'accessing' }
StDebuggerInspector >> assertionFailure [
	^assertionFailure 
]

{ #category : 'layout' }
StDebuggerInspector >> assertionFailureLayout [
	| assertionFailureLayout |
	
	assertionFailureLayout := SpPanedLayout newTopToBottom.
	assertionFailureLayout positionOfSlider: (self class maximizeAssertionSpec
			 ifTrue: [ 95 percent ]
			 ifFalse: [ 40 percent ]).
	assertionFailureLayout add: (SpBoxLayout newLeftToRight
			 add: (SpBoxLayout newTopToBottom
				add: #lateralToolbar expand: false;
				yourself)
			 expand: false;
			 add: #assertionFailure;
			 yourself).

	self class maximizeAssertionSpec ifFalse: [ 
		assertionFailureLayout add: #inspector ].
	^ assertionFailureLayout
]

{ #category : 'layout' }
StDebuggerInspector >> assertionLayoutSelector [
	^#assertionFailureLayout
]

{ #category : 'layout' }
StDebuggerInspector >> currentLayoutSelector [
	^currentLayoutSelector
]

{ #category : 'accessing' }
StDebuggerInspector >> debuggerInspectorModelClass [
	^ StDebuggerInspectorModel
]

{ #category : 'layout' }
StDebuggerInspector >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #inspector;
		  yourself
]

{ #category : 'layout' }
StDebuggerInspector >> defaultLayoutSelector [
	^#defaultLayout
]

{ #category : 'updating' }
StDebuggerInspector >> forceRawInspectionUpdate [

	self getRawInspectorPresenterOrNil ifNotNil: [ :inspection | 
		inspection update ]
]

{ #category : 'private' }
StDebuggerInspector >> getRawInspectorPresenterOrNil [
	^ inspector millerList pages first rawInspectorPageOrNil activePresenter
]

{ #category : 'private' }
StDebuggerInspector >> getRawInspectorSelectedPath [
	^ self getRawInspectorPresenterOrNil
		  ifNil: [ #(  ) ]
		  ifNotNil: [ :raw | raw selectedPath ]
]

{ #category : 'initialization' }
StDebuggerInspector >> initialize [

	super initialize.
	shouldBeUpdated := false
]

{ #category : 'initialization' }
StDebuggerInspector >> initializeLateralToolbar [
	| button |
	
	lateralToolbar := self newToolbar.
	lateralToolbar addStyle: 'stToolbar'.
	lateralToolbar beIcons.
	button := self newToolbarButton.

	button
		label: '';
		icon: (self iconNamed: #expandBox);
		help: 'Expand the diff view';
		action: [ 
			self class toggleMaximizeAssertionSpec.
			self setAssertionLayout ];
		borderWidth: 0.

	lateralToolbar add: button
]

{ #category : 'initialization' }
StDebuggerInspector >> initializePresenters [

	label := self newLabel.
	inspector := self instantiate: StInspectorPresenter on: self model.
	currentLayoutSelector := self defaultLayoutSelector.
	self initializeLateralToolbar
]

{ #category : 'accessing' }
StDebuggerInspector >> inspectedObject [

	^ self model inspectedObject
]

{ #category : 'accessing' }
StDebuggerInspector >> label: aString [

	label label: aString
]

{ #category : 'accessing - model' }
StDebuggerInspector >> model [

	^ model
]

{ #category : 'accessing - model' }
StDebuggerInspector >> model: aModel [

	model := aModel.
	inspector model: model
]

{ #category : 'accessing' }
StDebuggerInspector >> rawInspectionSelectionCache [
	^ rawInspectionSelectionCache ifNil: [ 
		  rawInspectionSelectionCache := Dictionary new ]
]

{ #category : 'private' }
StDebuggerInspector >> restoreRawInspectionSelectionForContext: aContext [
	aContext ifNil: [ ^ self ].
	self getRawInspectorPresenterOrNil
		ifNotNil: [ :raw | 
			| receiverClass selector path |
			receiverClass := aContext receiver class.
			selector := aContext selector.
			path := self rawInspectionSelectionCache
				at: receiverClass -> selector
				ifAbsent: [ #() ].
			path ifEmpty: [ self rawInspectionSelectionCache at: receiverClass ifAbsent: [ #() ] ].
			path ifEmpty: [ | roots pathStart |
					roots := raw attributeTable roots.
					pathStart := 1.
					1 to: roots size do: [ :i | 
						(roots at: i) key = 'Temps' ifTrue: [ pathStart := i ] ].
					path := {pathStart. 1} ].
			raw selectPath: path ]
]

{ #category : 'private' }
StDebuggerInspector >> saveRawInspectionSelectionForContext: aContext [
	| selectionPath |
	aContext ifNil: [ ^ self ].
	selectionPath := self getRawInspectorSelectedPath.
	self rawInspectionSelectionCache
		at: aContext receiver class -> aContext selector
		put: selectionPath.
	self rawInspectionSelectionCache
		at: aContext receiver class
		put: selectionPath
]

{ #category : 'layout' }
StDebuggerInspector >> setAssertionLayout [
	currentLayoutSelector := self assertionLayoutSelector.
	self layout: self assertionFailureLayout
]

{ #category : 'layout' }
StDebuggerInspector >> setDefaultLayout [
	
	currentLayoutSelector := self defaultLayoutSelector.
	self layout: self defaultLayout
]

{ #category : 'accessing - model' }
StDebuggerInspector >> setModelBeforeInitialization: aModel [

	model := aModel
]

{ #category : 'asserting' }
StDebuggerInspector >> shouldUpdate [

	shouldBeUpdated := true
]

{ #category : 'updating' }
StDebuggerInspector >> shouldUpdateContext: oldContext with: newContext [

	^ oldContext ~~ newContext or: [ shouldBeUpdated ]
]

{ #category : 'stepping' }
StDebuggerInspector >> step [
	inspector step
]

{ #category : 'updating' }
StDebuggerInspector >> updateEvaluationPaneReceiver [
	"| context evaluator |
	
	context := self model inspectedObject context.
	evaluator := inspector millerList pages first evaluator.
	evaluator beForContextReceiver: context"
]

{ #category : 'layout' }
StDebuggerInspector >> updateLayoutForContexts: aContext isAssertionFailure: isTopContextFailingAssertion [

	| assertionResult |
	isTopContextFailingAssertion ifFalse: [ 
		currentLayoutSelector = self defaultLayoutSelector ifTrue: [ ^ self ].
		self setDefaultLayout.
		^self ].
	currentLayoutSelector = self assertionLayoutSelector ifTrue: [ ^ self ].

	[ assertionResult := aContext findFailedAssertionResultsInSenderChain ]
		on: StDebuggeAssertionFailureContextNotFound
		do: [ self setDefaultLayout.
			^self ].		
	
	assertionFailure := StFailingAssertionInspector
		                    diffInspectorsFromActual: assertionResult actual
		                    expected: assertionResult expected
		                    application: self application.
	self setAssertionLayout
]

{ #category : 'updating' }
StDebuggerInspector >> updateWith: inspectedObject [

	| oldContext newContext |
	oldContext := self model inspectedObject ifNotNil: [ :dbgCtx | 
		              dbgCtx context ].
	newContext := inspectedObject ifNotNil: [ :dbgCtx | dbgCtx context ].
	(self shouldUpdateContext: oldContext with: newContext) ifFalse: [ ^ self ].

	shouldBeUpdated := false.
	self saveRawInspectionSelectionForContext: oldContext.
	self model: (self debuggerInspectorModelClass on: inspectedObject).
	self updateEvaluationPaneReceiver.
	self restoreRawInspectionSelectionForContext: newContext
]

{ #category : 'accessing' }
StDebuggerInspector >> windowTitle [

	 ^'Debugger Inspection'
]
