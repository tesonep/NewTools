Class {
	#name : 'StTarjanAlgorithmTest',
	#superclass : 'TestCase',
	#instVars : [
		'tarjanPackage',
		'packageA',
		'packageB',
		'packageC',
		'packageD',
		'packageE',
		'packageF',
		'packageG',
		'packageH',
		'anArray'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Algorithm',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Algorithm'
}

{ #category : 'running' }
StTarjanAlgorithmTest >> setUp [

	super setUp.
	tarjanPackage := AITarjan new.
	anArray := Array new: 8.
	packageA := StPackage onPackageNamed: 'A'.
	packageB := StPackage onPackageNamed: 'B'.
	packageC := StPackage onPackageNamed: 'C'.
	packageD := StPackage onPackageNamed: 'D'.
	packageE := StPackage onPackageNamed: 'E'.
	packageF := StPackage onPackageNamed: 'F'.
	packageG := StPackage onPackageNamed: 'G'.
	packageH := StPackage onPackageNamed: 'H'.
	anArray at: 1 put: packageA.
	anArray at: 2 put: packageB.
	anArray at: 3 put: packageC.
	anArray at: 4 put: packageD.
	anArray at: 5 put: packageE.
	anArray at: 6 put: packageF.
	anArray at: 7 put: packageG.
	anArray at: 8 put: packageH
]

{ #category : 'utilities' }
StTarjanAlgorithmTest >> stackSize [
	^ (tarjanPackage instVarNamed: 'stack') size
]

{ #category : 'tests' }
StTarjanAlgorithmTest >> testNoOutgoingDependenciesAfterTarjan [
	"test if we have 0 outgoing dependencies in each SCC after the algorithm"

	| aRelation aCollection sccs |
	aCollection := OrderedCollection withAll: (self packageOrganizer packages
			                select: [ :package | '*Collections*' match: package name asString ]
			                thenCollect: [ :package | package name ]).
	aRelation := StPackageRelationGraph onPackages: (aCollection collect: [ :each | StPackage onPackageNamed: each ]).
	aRelation
		computeStaticDependencies;
		removeInternalDependencies;
		removeOutgoingDependencies;
		combineDependencies.

	sccs := tarjanPackage runOnDAPackageRelationGraph: aRelation.

	self assert: (sccs anySatisfy: [ :scc | scc outgoing isEmpty ])
]

{ #category : 'tests' }
StTarjanAlgorithmTest >> testRunTarjan [
	"test the Tarjan algorithm on a simple graph with 8 nodes"
	| aPDPackageRelation  sccs |
	packageA add: (StPackageDependency from: packageA to: packageB).
	packageB add: (StPackageDependency from: packageB to: packageC).
	packageC add: (StPackageDependency from: packageC to: packageD).
	packageD add: (StPackageDependency from: packageD to: packageE).
	packageE add: (StPackageDependency from: packageE to: packageA).
	packageC add: (StPackageDependency from: packageC to: packageF).
	packageF add: (StPackageDependency from: packageF to: packageG).
	packageG add: (StPackageDependency from: packageG to: packageH).
	packageH add: (StPackageDependency from: packageH to: packageG).
	aPDPackageRelation := StPackageRelationGraph onPackages: anArray.
	sccs := tarjanPackage runOnDAPackageRelationGraph: aPDPackageRelation.

	"we must find 3 sccs, five two and one nodes"
	self assert: sccs size equals: 3.
	self assert: (sccs anySatisfy: [ :each | each packages size = 5 ]).
	self assert: (sccs anySatisfy: [ :each | each packages size = 2 ]).
	self assert: (sccs anySatisfy: [ :each | each packages size = 1 ])
]
