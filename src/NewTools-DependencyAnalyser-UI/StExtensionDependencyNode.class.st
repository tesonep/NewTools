"
A PDCycleNode is used to display a extension dependency in a tree.
"
Class {
	#name : 'StExtensionDependencyNode',
	#superclass : 'StMethodDependencyNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StExtensionDependencyNode >> icon [
	^  self iconNamed: #edit
]
