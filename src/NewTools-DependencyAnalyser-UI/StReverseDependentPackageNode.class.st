"
A DAReverseDependentPackageNode is used to display a dependent package in a reverse tree.
"
Class {
	#name : 'StReverseDependentPackageNode',
	#superclass : 'StAbstractPackageNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'api' }
StReverseDependentPackageNode >> childNodeClassFor: anItem [
	^ anItem nodeClass
]

{ #category : 'accessing' }
StReverseDependentPackageNode >> children [
	^ self dependenciesToParentNode dependencies
]

{ #category : 'private' }
StReverseDependentPackageNode >> dependenciesToParentNode [
	^ self content daPackage
		compositeDependencyTo: (self parentNode content daPackage)
]

{ #category : 'testing' }
StReverseDependentPackageNode >> hasChildren [
	^ self dependenciesToParentNode isNotNil
]

{ #category : 'accessing' }
StReverseDependentPackageNode >> icon [
	^ self iconNamed: #back
]
