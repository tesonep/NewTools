"
A PDMethodNode is the superclass node for PDReferenceDependencyNode and PDExtensionDependencyNode. 
Indeed these two nodes have the same behavior to browse the dependency in the browser

"
Class {
	#name : 'StMethodDependencyNode',
	#superclass : 'StNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'browse-nautilus' }
StMethodDependencyNode >> selectInBrowser [
	self selectMethod: self content method
]
