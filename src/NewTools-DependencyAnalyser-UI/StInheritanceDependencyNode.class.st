"
A node used to display a inheritance dependency in a tree.
"
Class {
	#name : 'StInheritanceDependencyNode',
	#superclass : 'StClassNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StInheritanceDependencyNode >> icon [
	^ self iconNamed: #arrowUp
]

{ #category : 'accessing' }
StInheritanceDependencyNode >> isClassToDependencyNode [
	^ true
]

{ #category : 'browse-nautilus' }
StInheritanceDependencyNode >> spawnNewBrowser [
	self browseClass: self content superclass
]
