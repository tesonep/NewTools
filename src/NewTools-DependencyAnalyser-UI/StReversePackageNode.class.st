"
A DAReversePackageNode is a node to display a package in the tree during a reverse analysis.
"
Class {
	#name : 'StReversePackageNode',
	#superclass : 'StAbstractPackageNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'api' }
StReversePackageNode >> childNodeClassFor: anItem [
	^ StReverseDependentPackageNode
]

{ #category : 'accessing' }
StReversePackageNode >> children [
	^ (self content usersOfPackage
		collect: [ :each | each asPackageDependencyWrapper ]) asSortedCollection
]

{ #category : 'testing' }
StReversePackageNode >> hasChildren [
	^ true
]

{ #category : 'accessing' }
StReversePackageNode >> icon [
	^ self iconNamed: #package
]
