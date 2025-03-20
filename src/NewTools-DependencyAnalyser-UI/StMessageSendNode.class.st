"
I'm a tree node representing a specific message send in the package under analysis.
"
Class {
	#name : 'StMessageSendNode',
	#superclass : 'StMethodDependencyNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StMessageSendNode >> icon [
	^ self iconNamed: #smallLanguage
]

{ #category : 'displaying' }
StMessageSendNode >> label [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Sent in ';
			nextPutAll: self content methodClass asString;
			nextPutAll: '>>';
			nextPutAll: self content selector ]
]
