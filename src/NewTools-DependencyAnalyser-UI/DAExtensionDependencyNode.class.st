"
A PDCycleNode is used to display a extension dependency in a tree.
"
Class {
	#name : 'DAExtensionDependencyNode',
	#superclass : 'DAMethodDependencyNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
DAExtensionDependencyNode >> icon [
	^  self iconNamed: #edit
]
