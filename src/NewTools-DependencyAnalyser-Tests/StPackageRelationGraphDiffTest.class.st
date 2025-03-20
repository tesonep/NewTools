Class {
	#name : 'StPackageRelationGraphDiffTest',
	#superclass : 'TestCase',
	#instVars : [
		'oldRelationGraph',
		'newRelationGraph',
		'packageRelationGraphDiff',
		'packageA',
		'packageB'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Packages',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Packages'
}

{ #category : 'running' }
StPackageRelationGraphDiffTest >> setUp [

	| packageCollectionsAbstract packageCollectionsString |
	super setUp.
	packageA := StPackage onPackageNamed: 'A'.
	packageB := StPackage onPackageNamed: 'B'.
	packageCollectionsAbstract := StPackage onPackageNamed: 'Collections-Abstract'.
	packageCollectionsString := StPackage onPackageNamed: 'Collections-Strings'.
	oldRelationGraph := StPackageRelationGraph onPackages: (Array with: packageCollectionsAbstract with: packageCollectionsString).
	newRelationGraph := StPackageRelationGraph onPackages:
		                    (Array with: (StPackage onPackageNamed: 'Collections-Abstract') with: (StPackage onPackageNamed: 'Collections-Strings')).
	oldRelationGraph build.
	newRelationGraph build.

	packageRelationGraphDiff := StPackageRelationGraphDiff new
		                            oldRelationGraph: oldRelationGraph;
		                            newRelationGraph: newRelationGraph
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testHasChangedForPackageItemDiff [
	| first second |
	first := newRelationGraph seenPackages first.
	second := newRelationGraph seenPackages last.

	first clearDependencies.

	packageRelationGraphDiff make.

	self assert: ((packageRelationGraphDiff packageDiffNamed: first packageName) hasChanged).
	self deny: ((packageRelationGraphDiff packageDiffNamed: second packageName) hasChanged)
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testHasChangedForPackageItemDiffOnOneDependentPackageRemoved [
	| first |
	first := newRelationGraph seenPackages first.
	first dependencies remove: (first dependencies anyOne).

	packageRelationGraphDiff make.

	self assert: ((packageRelationGraphDiff packageDiffNamed: first packageName) hasChanged)
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testMakeDependentPackagesDiffOnSameGraph [
	packageRelationGraphDiff makePackagesDiff.
	self assertEmpty: packageRelationGraphDiff dependentPackagesDiff
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testMakeDependentPackagesDifferentOnDifferentGraph [
	| oldSize |
	oldSize := newRelationGraph seenPackages first dependentPackages size.
	newRelationGraph seenPackages first clearDependencies.

	packageRelationGraphDiff make.

	self assert: packageRelationGraphDiff dependentPackagesDiffRemoved size equals: oldSize.
	self assert: packageRelationGraphDiff dependentPackagesDiffUnderteminate size equals: newRelationGraph seenPackages last dependentPackages size
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testMakePackagesDiffOnDifferentGraph [
	newRelationGraph removePackage: 'Collections-Abstract'.
	packageRelationGraphDiff makePackagesDiff.

	self assert: packageRelationGraphDiff packagesDiffRemovedSize equals: 1.
	self assert: packageRelationGraphDiff packagesDiffUnderteminateSize equals: 1
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testMakePackagesDiffOnSameGraph [
	packageRelationGraphDiff makePackagesDiff.

	self assert: packageRelationGraphDiff packagesDiff size equals: oldRelationGraph seenPackages size.
	self assert: (packageRelationGraphDiff packagesDiff allSatisfy: [ :item | item isUnderteminate ])
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testPackagesDiffToDisplay [
	| first second |
	first := newRelationGraph seenPackages first.
	second := newRelationGraph seenPackages last.

	first clearDependencies.
	second dependencies remove: second dependencies anyOne.

	packageRelationGraphDiff make.
	self assert: packageRelationGraphDiff packagesDiffToDisplay size equals: 2
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testPackagesDiffToDisplayBis [
	| first |
	first := newRelationGraph seenPackages first.
	first clearDependencies.
	packageRelationGraphDiff make.

	self assert: packageRelationGraphDiff packagesDiffToDisplay size equals: 1
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testPackagesDiffToDisplayOnSameGraph [
	packageRelationGraphDiff make.
	self assertEmpty: packageRelationGraphDiff packagesDiffToDisplay
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testRemovedDependentPackagesIncludesFrom [
	| dependentPackages package |
	package := newRelationGraph seenPackages first.
	dependentPackages := package dependentPackages.

	package clearDependencies.

	packageRelationGraphDiff make.

	self assert: (packageRelationGraphDiff removedDependentPackagesIncludes: dependentPackages anyOne from: package)
]

{ #category : 'running' }
StPackageRelationGraphDiffTest >> testRemovedPackagesIncludes [

	newRelationGraph clearPackages.
	packageRelationGraphDiff makePackagesDiff.

	self assert: (packageRelationGraphDiff removedPackagesIncludes: (StPackage onPackageNamed: 'Collections-Abstract')).
	self assert: (packageRelationGraphDiff removedPackagesIncludes: (StPackage onPackageNamed: 'Collections-Strings'))
]
