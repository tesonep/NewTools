Class {
	#name : 'StPackageTest',
	#superclass : 'TestCase',
	#instVars : [
		'aPackage',
		'aSecondPackage',
		'packageA',
		'packageB',
		'packageC'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Packages',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Packages'
}

{ #category : 'running' }
StPackageTest >> setUp [

	super setUp.
	aPackage := StPackage onPackageNamed: 'Collections-Abstract'.
	aSecondPackage := StPackage onPackageNamed: 'Collections-Arithmetic'.
	packageA := StPackage onPackageNamed: 'A'.
	packageB := StPackage onPackageNamed: 'B'.
	packageC := StPackage onPackageNamed: 'C'.
	aPackage add: (StInheritanceDependency from: aPackage to: aSecondPackage)
]

{ #category : 'tests' }
StPackageTest >> testAdd [
	| aDependency |
	aDependency := StPackageDependency from: aPackage to: aSecondPackage.
	aPackage add: aDependency.

	self assert: aPackage dependencies size equals: 2.
	self assert: (aPackage dependencies includes: aDependency)
]

{ #category : 'tests' }
StPackageTest >> testBeIncluded [
	aPackage beIncluded.
	self assert: (aPackage isIncluded)
]

{ #category : 'tests' }
StPackageTest >> testCleardependencies [
	aPackage clearDependencies.
	self assertEmpty: aPackage dependencies
]

{ #category : 'tests' }
StPackageTest >> testDependantPackages [
	| aCollection |
	aPackage add: (StPackageDependency from: aPackage to: packageA).

	aCollection := aPackage dependentPackages.
	self assert: (aCollection includes: packageA).
	self assert: (aCollection includes: aSecondPackage).
	self assert: aCollection size equals: 2
]

{ #category : 'tests' }
StPackageTest >> testDependenciesFrom [
	| aRelationGraph |
	aRelationGraph := StPackageRelationGraph new.
	[ aRelationGraph
		computeStaticDependencies: aPackage;
		combineDependencies: aPackage ]
		on: StPotentialOutDatedDependencyWarning
		do: [ :ex | ex resume "ignore" ].
	self
		assert:
			((aPackage dependenciesFrom: Collection) allSatisfy: [ :dependency | dependency theClass = Collection ])
]

{ #category : 'tests' }
StPackageTest >> testDependenciesSize [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency from: packageA to: packageB.
	aCompositeDependency add: (StInheritanceDependency from: aPackage to: packageB).
	aCompositeDependency add: (StInheritanceDependency from: aPackage to: packageB).
	self assert: aPackage dependenciesSize equals: 1.
	aPackage add: aCompositeDependency.
	self assert: aPackage dependenciesSize equals: 3
]

{ #category : 'running' }
StPackageTest >> testDependenciesSizeTo [
	packageA
		add: (StInheritanceDependency from: packageA to: packageB);
		add: (StInheritanceDependency from: packageA to: packageC).
	self assert: (packageA dependenciesSizeTo: packageB) equals: 1
]

{ #category : 'tests' }
StPackageTest >> testDependenciesTo [
	self assert: (aPackage dependenciesTo: aSecondPackage packageName) size equals: 1.
	self assertEmpty: (aPackage dependenciesTo: 'Test')
]

{ #category : 'tests' }
StPackageTest >> testDependentPackages [
	self assert: aPackage dependentPackages size equals: 1.
	self assert: (aPackage dependentPackages anySatisfy: [ :package | package = aSecondPackage ]).
	self assertEmpty: aSecondPackage dependentPackages
]

{ #category : 'tests' }
StPackageTest >> testDependentPackagesSize [
	| dependency |
	self assert: aPackage dependentPackagesSize equals: 1.
	dependency := StPackageDependency from: aPackage to: packageA.
	aPackage add: dependency.
	self assert: aPackage dependentPackagesSize equals: 2
]

{ #category : 'tests' }
StPackageTest >> testNumberOfDependentPackage [
	self assert: aPackage dependentPackagesSize equals: 1.
	aPackage add: (StPackageDependency from: aPackage to: packageA).
	self assert: aPackage dependentPackagesSize equals: 2
]

{ #category : 'tests' }
StPackageTest >> testPackageName [
	self assert: packageA packageName equals: 'A'
]

{ #category : 'tests' }
StPackageTest >> testReferenceDependenciesFrom [
	| aRelationGraph |
	aRelationGraph := StPackageRelationGraph new.
	[ aRelationGraph
		computeStaticDependencies: aPackage;
		combineDependencies: aPackage ]
	on: StPotentialOutDatedDependencyWarning
	do: [ :ex | ex resume "ignore" ].
	self
		assert:
			((aPackage referenceDependenciesFrom: Collection) allSatisfy: [ :dependency | dependency isReferenceDependency ]).
	self
		assert:
			((aPackage referenceDependenciesFrom: Collection) allSatisfy: [ :dependency | dependency theClass = Collection ])
]

{ #category : 'tests' }
StPackageTest >> testRemoveAllInternal [
	aPackage clearDependencies.
	aPackage add: (StPackageDependency from: aPackage to: aPackage).
	aPackage add: (StPackageDependency from: aSecondPackage to: aSecondPackage).
	aPackage removeAllInternal.
	self assertEmpty: aPackage dependencies
]
