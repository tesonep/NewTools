"
A node used to display a trait dependency in a tree.
"
Class {
	#name : 'StTraitDependencyNode',
	#superclass : 'StClassNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StTraitDependencyNode >> icon [
	^  Smalltalk ui icons iconNamed: #trait
]

{ #category : 'browse-nautilus' }
StTraitDependencyNode >> spawnNewBrowser [
	self browseClass: self content trait
]
