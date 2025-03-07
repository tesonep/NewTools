Class {
	#name : 'StPackageCycleTest',
	#superclass : 'TestCase',
	#instVars : [
		'aPDPackageCycle',
		'packageA',
		'packageB',
		'packageC'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Packages',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Packages'
}

{ #category : 'running' }
StPackageCycleTest >> setUp [

	super setUp.
	aPDPackageCycle := StPackageCycle new.
	packageA := StPackage onPackageNamed: 'A'.
	packageB := StPackage onPackageNamed: 'B'.
	packageC := StPackage onPackageNamed: 'C'
]

{ #category : 'tests' }
StPackageCycleTest >> testIsAtLeastInCycle [
	| aCollectionOfPDPackage |
	aCollectionOfPDPackage  := OrderedCollection new.
	aCollectionOfPDPackage
		add: packageA;
		add: packageB;
		add: packageC.

	aPDPackageCycle
		addPackage: packageA;
		addPackage: packageB.

	self assert: (aPDPackageCycle isAtLeastInCycle: aCollectionOfPDPackage).
	aCollectionOfPDPackage remove: packageA; remove: packageB.
	self deny: (aPDPackageCycle isAtLeastInCycle: aCollectionOfPDPackage)
]

{ #category : 'tests' }
StPackageCycleTest >> testIsInCycle [
	aPDPackageCycle addPackage: packageA.
	self assert: (aPDPackageCycle isInCycle: packageA)
]

{ #category : 'running' }
StPackageCycleTest >> testRemoveOutgoingDependencies [

	| firstPackage secondPackage outgoingPackage otherOutgoingPackage |
	firstPackage := StPackage onPackageNamed: 'A'.
	secondPackage := StPackage onPackageNamed: 'B'.
	outgoingPackage := StPackage onPackageNamed: 'C'.
	otherOutgoingPackage := StPackage onPackageNamed: 'D'.
	firstPackage add: (StCompositeDependency from: firstPackage to: secondPackage).
	firstPackage add: (StCompositeDependency from: firstPackage to: outgoingPackage).
	firstPackage add: (StCompositeDependency from: firstPackage to: otherOutgoingPackage).
	secondPackage add: (StCompositeDependency from: secondPackage to: firstPackage).
	secondPackage add: (StCompositeDependency from: secondPackage to: outgoingPackage).
	aPDPackageCycle
		addPackage: firstPackage;
		addPackage: secondPackage.
	aPDPackageCycle removeOutgoingDependencies.
	"at this point, package A and B does not have dependency with C and D, because C is not in the cycle"
	"self halt."
	self deny: (aPDPackageCycle hasOutgoingDependencies: firstPackage).
	self deny: (aPDPackageCycle hasOutgoingDependencies: secondPackage)
]

{ #category : 'tests' }
StPackageCycleTest >> testReversedCycle [
	aPDPackageCycle
		addPackage: packageA;
		addPackage: packageB;
		addPackage: packageC;
		yourself.
	aPDPackageCycle reversedCycle.
	self assert: (aPDPackageCycle packageAt: 1) equals: packageC.
	self assert: (aPDPackageCycle packageAt: 2) equals: packageB.
	self assert: (aPDPackageCycle packageAt: 3) equals: packageA
]

{ #category : 'tests' }
StPackageCycleTest >> testSizeOfCycles [

	self assert: aPDPackageCycle size equals: 0.
	aPDPackageCycle addPackage: (StPackage onPackageNamed: 'Kernel').
	aPDPackageCycle addPackage: (StPackage onPackageNamed: 'Collections-Abstract').
	self assert: aPDPackageCycle size equals: 2
]
