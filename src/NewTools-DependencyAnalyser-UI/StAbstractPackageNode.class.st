"
Abstract class from package node displaying in the tree.
"
Class {
	#name : 'StAbstractPackageNode',
	#superclass : 'StNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'testing' }
StAbstractPackageNode class >> isAbstract [

	^ self == StAbstractPackageNode
]

{ #category : 'accessing' }
StAbstractPackageNode >> packageName [
	^ self content target packageName
]

{ #category : 'browse-nautilus' }
StAbstractPackageNode >> selectInBrowser [

	self selectPackage: self systemPackage
]

{ #category : 'accessing' }
StAbstractPackageNode >> systemPackage [

	^ self content systemPackage
]
