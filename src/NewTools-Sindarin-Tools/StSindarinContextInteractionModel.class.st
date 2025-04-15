"
The Sindarin scripting context interaction model supersedes the debugger interaction model in Sindarin debugger scripting presenters, with local custom bindings configured by external clients.
These custom bindings are selected in priority when looking up for bindings.

This interaction model returns the direct value of variables put in bindings.
"
Class {
	#name : 'StSindarinContextInteractionModel',
	#superclass : 'StDebuggerContextInteractionModel',
	#category : 'NewTools-Sindarin-Tools-Model',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Model'
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
