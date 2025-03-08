Class {
	#name : 'StPackageDependencyWrapperTest',
	#superclass : 'TestCase',
	#instVars : [
		'packageA',
		'aPDPackageDependencyWrapper'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Packages',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Packages'
}

{ #category : 'running' }
StPackageDependencyWrapperTest >> setUp [

	super setUp.
	packageA := StPackage onPackageNamed: 'A'
]

{ #category : 'tests' }
StPackageDependencyWrapperTest >> testInitializeFrom [
	aPDPackageDependencyWrapper := StPackageDependencyWrapper newWith: packageA.
	self assert: aPDPackageDependencyWrapper daPackage equals: packageA
]
