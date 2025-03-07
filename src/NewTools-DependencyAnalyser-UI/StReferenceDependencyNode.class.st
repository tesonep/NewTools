"
A PDCycleNode is used to display a reference dependency in a tree.
"
Class {
	#name : 'StReferenceDependencyNode',
	#superclass : 'StMethodDependencyNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'testing' }
StReferenceDependencyNode >> browseSendersOrUsers [
]

{ #category : 'accessing' }
StReferenceDependencyNode >> icon [
	^ self iconNamed: #class
]

{ #category : 'testing' }
StReferenceDependencyNode >> isClassToDependencyNode [
	^ true
]

{ #category : 'testing' }
StReferenceDependencyNode >> isReferenceNode [
	  ^ true
]

{ #category : 'browse-nautilus' }
StReferenceDependencyNode >> spawnNewBrowser [
	| classToBrowse |
	classToBrowse := self content reference.
	self browseClass: classToBrowse
]
