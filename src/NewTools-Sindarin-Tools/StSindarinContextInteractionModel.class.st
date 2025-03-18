"
The Sindarin scripting context interaction model supersedes the debugger interaction model in Sindarin debugger scripting presenters, with local custom bindings configured by external clients.
These custom bindings are selected in priority when looking up for bindings.
"
Class {
	#name : 'StSindarinContextInteractionModel',
	#superclass : 'StDebuggerContextInteractionModel',
	#category : 'NewTools-Sindarin-Tools',
	#package : 'NewTools-Sindarin-Tools'
}

{ #category : 'binding' }
StSindarinContextInteractionModel >> bindingOf: aString [

	^ self bindings
		  associationAt: aString
		  ifAbsent: [ super bindingOf: aString ]
]

{ #category : 'binding' }
StSindarinContextInteractionModel >> isScripting [
	^true
]
