"
A DADependentPackageNode is used to display a dependent package in a tree.
"
Class {
	#name : 'StDependentPackageNode',
	#superclass : 'StAbstractPackageNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'api' }
StDependentPackageNode >> childNodeClassFor: anItem [
	^ anItem nodeClass
]

{ #category : 'accessing' }
StDependentPackageNode >> children [
	^ self compositeDependencyTo dependencies
]

{ #category : 'accessing' }
StDependentPackageNode >> compositeDependencyTo [
	"should return one composite dependency anytime"
	^ self content
]

{ #category : 'accessing' }
StDependentPackageNode >> daPackage [
	^ self parentNode daPackage
]

{ #category : 'testing' }
StDependentPackageNode >> hasChildren [
	^ [ self content dependencies notEmpty ]
]

{ #category : 'accessing' }
StDependentPackageNode >> icon [
	^ self iconNamed: #forward
]

{ #category : 'testing' }
StDependentPackageNode >> isPackageNode [
	^ true
]

{ #category : 'displaying' }
StDependentPackageNode >> label [
	^ self systemPackage name
]

{ #category : 'accessing' }
StDependentPackageNode >> systemPackage [

	^ self content target systemPackage
]
