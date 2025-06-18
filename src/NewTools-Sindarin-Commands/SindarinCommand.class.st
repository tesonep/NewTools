Class {
	#name : 'SindarinCommand',
	#superclass : 'CmCommand',
	#instVars : [
		'sindarin'
	],
	#category : 'NewTools-Sindarin-Commands',
	#package : 'NewTools-Sindarin-Commands'
}

{ #category : 'initialization' }
SindarinCommand class >> defaultIconName [
	^self subclassResponsibility 
]

{ #category : 'instance creation' }
SindarinCommand class >> forSpecContext: anObject [
	self flag: 'Why is this class needed besides this helper?'.
	^ (self forSpecWithIconNamed: self defaultIconName)
		context: anObject;
		yourself
]

{ #category : 'testing' }
SindarinCommand class >> isAbstract [

	^ self == SindarinCommand
]

{ #category : 'accessing' }
SindarinCommand >> context: aDebugger [
	super context: aDebugger.
	sindarin := aDebugger sindarinDebugger.
	
]

{ #category : 'accessing' }
SindarinCommand >> debuggerPresenter [
	^self context
]
