"
I'm a tree node representing a specific message send in the package under analysis.
"
Class {
	#name : 'StMessageSendDependencyNode',
	#superclass : 'StMessageSendNode',
	#instVars : [
		'sentMessages'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'displaying' }
StMessageSendDependencyNode >> label [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: self content methodClass asString;
			nextPutAll: '>>';
			nextPutAll: self content selector;
			nextPutAll: ' sends #'.
		sentMessages do: [ :message |
			stream nextPutAll: message ] ]
]

{ #category : 'setting' }
StMessageSendDependencyNode >> sentMessages: aListOfSelectors [
	sentMessages := aListOfSelectors
]
