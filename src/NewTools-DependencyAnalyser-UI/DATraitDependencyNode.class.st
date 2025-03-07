"
A node used to display a trait dependency in a tree.
"
Class {
	#name : 'DATraitDependencyNode',
	#superclass : 'DAClassNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
DATraitDependencyNode >> icon [
	^  Smalltalk ui icons iconNamed: #trait
]

{ #category : 'browse-nautilus' }
DATraitDependencyNode >> spawnNewBrowser [
	self browseClass: self content trait
]
