Class {
	#name : 'StPackageCycleDetectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'packageA',
		'packageB',
		'packageC',
		'packageD',
		'packageE',
		'aPackageCycleDetection',
		'cycleA',
		'cycleB',
		'cycleC'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Packages',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Packages'
}

{ #category : 'utilities' }
StPackageCycleDetectorTest >> cyclesSize [
	^ aPackageCycleDetection cycles size
]

{ #category : 'utilities' }
StPackageCycleDetectorTest >> graphWithThreeCycles [
	| anArray |
	anArray := Array new: 3.
	anArray at: 1 put: packageA.
	anArray at: 2 put: packageB.
	anArray at: 3 put: packageC.
	packageA add: (StPackageDependency from: packageA to: packageB).
	packageB add: (StPackageDependency from: packageB to: packageA).
	packageA add: (StPackageDependency from: packageA to: packageC).
	packageC add: (StPackageDependency from: packageB to: packageA).
	packageC add: (StPackageDependency from: packageB to: packageB).
	^ StPackageRelationGraph onPackages: anArray
]

{ #category : 'utilities' }
StPackageCycleDetectorTest >> queue [
	^ aPackageCycleDetection instVarNamed: 'queue'
]

{ #category : 'running' }
StPackageCycleDetectorTest >> setUp [

	super setUp.
	aPackageCycleDetection := StPackageCycleDetector new.
	packageA := StPackage onPackageNamed: 'A'.
	packageB := StPackage onPackageNamed: 'B'.
	packageC := StPackage onPackageNamed: 'C'.
	packageD := StPackage onPackageNamed: 'D'.
	packageE := StPackage onPackageNamed: 'E'.
	cycleA := StPackageCycle new.
	cycleB := StPackageCycle new.
	cycleC := StPackageCycle new
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testAddCycle [
	aPackageCycleDetection addCycle: StPackageCycle new.
	self assert: aPackageCycleDetection cycles size equals: 1
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testAddVisitedNodes [
	aPackageCycleDetection initializeVisitedNodes.
	aPackageCycleDetection addVisitedNodes: packageA.
	self assert: aPackageCycleDetection visitedNodes size equals: 1.
	self assert: (aPackageCycleDetection visitedNodes includes: packageA)
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testBuildCycleUntil [
	| cycle |
	packageA bfsParent: packageB.
	packageB bfsParent: packageC.
	packageC bfsParent: packageD.
	aPackageCycleDetection buildCycleUntil: packageA.
	self assert: self cyclesSize equals: 1.
	aPackageCycleDetection buildCycleUntil: packageA.
	"cycle already present"
	self assert: self cyclesSize equals: 1.
	cycle := aPackageCycleDetection cycles first.
	self assert: (cycle isInCycle: packageA).
	self assert: (cycle isInCycle: packageB).
	self assert: (cycle isInCycle: packageC).
	self assert: (cycle isInCycle: packageD)
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testCycleAlreadyFound [
	| cycle otherCycle |
	cycle := StPackageCycle new.
	cycle addPackage: packageA.
	cycle addPackage: packageB.
	aPackageCycleDetection addCycle: cycle.
	otherCycle := StPackageCycle new.
	otherCycle addPackage: packageA.
	self deny: (aPackageCycleDetection cycleAlreadyFound: otherCycle).
	otherCycle addPackage: packageB.
	self assert: (aPackageCycleDetection cycleAlreadyFound: otherCycle)
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testCyclesWith [
	cycleA
		addPackage: packageA;
		addPackage: packageB.

	cycleB
		addPackage: packageC;
		addPackage: packageD;
		addPackage: packageE.

	cycleC
		addPackage: packageA;
		addPackage: packageE.

	aPackageCycleDetection
		addCycle: cycleA;
		addCycle: cycleB;
		addCycle: cycleC.

	self assert: (aPackageCycleDetection cyclesWith: packageA) size equals: 2.
	self assert: (aPackageCycleDetection cyclesWith: packageC) size equals: 1.
	self assert: (aPackageCycleDetection cyclesWith: packageE) size equals: 2
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testCyclesWithAtLeast [
	| aCollectionOfPDPackage |
	aCollectionOfPDPackage := OrderedCollection new.
	aCollectionOfPDPackage
		add: packageA;
		add: packageB.

	cycleA
		addPackage: packageA;
		addPackage: packageB.

	cycleB
		addPackage: packageC;
		addPackage: packageD;
		addPackage: packageE.

	cycleC addPackage: packageE.

	aPackageCycleDetection
		addCycle: cycleA;
		addCycle: cycleB;
		addCycle: cycleC.

	self assert: (aPackageCycleDetection cyclesWithAtLeast: aCollectionOfPDPackage) size equals: 1
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testDequeue [
	| dequeue |
	aPackageCycleDetection initializeQueueWith: packageA.
	dequeue := aPackageCycleDetection dequeue.
	self assert: dequeue equals: packageA.
	self assertEmpty: self queue
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testEnqueue [
	aPackageCycleDetection initializeQueueWith: packageA.
	self assert: self queue size equals: 1.
	aPackageCycleDetection enqueue: packageB.
	self assert: self queue size equals: 2
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testFindCyclesOne [
	"we must find 1 cycles in this acyclic graph"

	| aPDPackageRelation anArray |
	anArray := Array new: 3.
	anArray at: 1 put: packageA.
	anArray at: 2 put: packageB.
	anArray at: 3 put: packageC.
	packageA add: (StPackageDependency from: packageA to: packageB).
	packageB add: (StPackageDependency from: packageB to: packageC).
	packageC add: (StPackageDependency from: packageC to: packageA).
	aPDPackageRelation := StPackageRelationGraph onPackages: anArray.
	aPackageCycleDetection findCycles: aPDPackageRelation.
	self assert: aPackageCycleDetection cycles size equals: 1
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testFindCyclesThreeNodes [
	| aPDPackageRelation |
	aPDPackageRelation := self graphWithThreeCycles.
	aPackageCycleDetection findCycles: aPDPackageRelation.
	self assert: aPackageCycleDetection cycles size equals: 3
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testInitializeQueueWith [
	| dequeue |
	aPackageCycleDetection initializeQueueWith: packageA.
	self assert: self queue isNotNil.
	self assert: self queue size equals: 1.
	dequeue := aPackageCycleDetection dequeue.
	self assert: dequeue equals: packageA
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testIsVisitedOrInStack [
	aPackageCycleDetection initializeVisitedNodes.
	aPackageCycleDetection initializeQueueWith: packageA.
	self assert: (aPackageCycleDetection isVisitedOrInQueue: packageA).
	aPackageCycleDetection dequeue.
	self deny: (aPackageCycleDetection isVisitedOrInQueue: packageA).
	aPackageCycleDetection addVisitedNodes: packageA.
	self assert: (aPackageCycleDetection isVisitedOrInQueue: packageA)
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testReset [
	| aPDPackageRelation |
	aPDPackageRelation := self graphWithThreeCycles.
	aPackageCycleDetection findCycles: aPDPackageRelation.
	self assert: aPackageCycleDetection cycles size equals: 3.
	aPackageCycleDetection reset.
	self assertEmpty: aPackageCycleDetection cycles
]

{ #category : 'tests' }
StPackageCycleDetectorTest >> testfindCycles [
	"the graph test is the SCC 1 from the paper"
	| aPDPackageRelation anArray |
	anArray := Array new: 5.
	anArray at: 1 put: packageA.
	anArray at: 2 put: packageB.
	anArray at: 3 put: packageC.
	anArray at: 4 put: packageD.
	anArray at: 5 put: packageE.
	(packageA) add: (StPackageDependency from: (packageA) to: (packageB)).
	(packageB) add: (StPackageDependency from: (packageB) to: (packageC)).
	(packageB) add: (StPackageDependency from: (packageB) to: (packageA)).
	(packageB) add: (StPackageDependency from: (packageB) to: (packageD)).
	(packageC) add: (StPackageDependency from: (packageC) to: (packageD)).
	(packageD) add: (StPackageDependency from: (packageD) to: (packageE)).
	(packageD) add: (StPackageDependency from: (packageD) to: (packageB)).
	(packageE) add: (StPackageDependency from: (packageE) to: (packageA)).
	aPDPackageRelation := StPackageRelationGraph onPackages: anArray.
	aPackageCycleDetection findCycles: aPDPackageRelation.
	self assert: (aPackageCycleDetection  cycles anySatisfy: [ :cycle | ((cycle size = 2) or: (cycle size= 4)) or: (cycle size = 3) ])
]

{ #category : 'utilities' }
StPackageCycleDetectorTest >> visitedNodes [
	^ aPackageCycleDetection instVarNamed: 'visitedNodes'
]
