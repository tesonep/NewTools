"
A DAClassDependencyNode is the superclass node for DAInheritanceDependencyNode and DATraitDependencyNode. Indeed these two nodes have the same behavior to browse the dependency in the browser

"
Class {
	#name : 'StClassNode',
	#superclass : 'StNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'browse-nautilus' }
StClassNode >> classFromContent [
	^ self content theClass
]

{ #category : 'browse-nautilus' }
StClassNode >> selectInBrowser [
	self selectClass: self classFromContent
]
