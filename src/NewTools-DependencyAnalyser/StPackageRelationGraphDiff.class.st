"
A PDPackageRelationGraphDiff do the diff between two PDPackageRelationGraph (an older and a newer) to detect :

 - which packages added/removed : packagesDiff.
 - which dependent packages added/removed from a package : dependentPackagesDiff.
 - which dependencies added/removed from a dependent package.
"
Class {
	#name : 'StPackageRelationGraphDiff',
	#superclass : 'Object',
	#instVars : [
		'oldRelationGraph',
		'newRelationGraph',
		'packagesDiff',
		'dependentPackagesDiff'
	],
	#category : 'NewTools-DependencyAnalyser-Diff',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Diff'
}

{ #category : 'private' }
StPackageRelationGraphDiff class >> loadFrom: aSerializeFile [
	^ self new oldRelationGraph: (FLMaterializer new
		filePath: aSerializeFile;
		materializeRoot)
]

{ #category : 'private' }
StPackageRelationGraphDiff class >> loadFrom: aSerializeFile with: newRelationGraph [
	^ self new
		oldRelationGraph: (FLMaterializer new
			filePath: aSerializeFile;
			materializeRoot);
		newRelationGraph: newRelationGraph
]

{ #category : 'adding' }
StPackageRelationGraphDiff >> addNewDependentPackage: package from: parent [
	^ dependentPackagesDiff
		add:
			((StDependentPackageItemDiff
				newWith: package)
				beNew;
				parent: parent;
				diff: self);
		yourself
]

{ #category : 'adding' }
StPackageRelationGraphDiff >> addNewPackage: seenPackage [
	^ packagesDiff
		add:
			((StPackageItemDiff newWith: seenPackage)
				beNew;
				diff: self);
		yourself
]

{ #category : 'adding' }
StPackageRelationGraphDiff >> addRemovedDependentPackage: package from: parent [
	^ dependentPackagesDiff
		add:
			((StDependentPackageItemDiff
				newWith: package)
				beRemoved;
				parent: parent;
				diff: self);
		yourself
]

{ #category : 'adding' }
StPackageRelationGraphDiff >> addRemovedPackage: seenPackage [
	^ packagesDiff
		add:
			((StPackageItemDiff newWith: seenPackage)
				beRemoved;
				diff: self);
		yourself
]

{ #category : 'adding' }
StPackageRelationGraphDiff >> addUndeterminateDependentPackage: aPackage from: parent [
	^ dependentPackagesDiff
		add:
				((StDependentPackageItemDiff newWith: aPackage)
						beUnderteminate;
						parent: parent;
						diff: self);
		yourself
]

{ #category : 'adding' }
StPackageRelationGraphDiff >> addUndeterminatePackage: aPackage [
	^ packagesDiff
		add:
			((StPackageItemDiff newWith: aPackage)
				beUnderteminate;
				diff: self);
				yourself
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> dependentPackagesDiff [
	^ dependentPackagesDiff
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> dependentPackagesDiffNew [
	^ dependentPackagesDiff select: [ :each | each isNew ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> dependentPackagesDiffRemoved [
	^ dependentPackagesDiff select: [ :each | each isRemoved ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> dependentPackagesDiffUnderteminate [
	^ dependentPackagesDiff select: [ :each | each isUnderteminate ]
]

{ #category : 'initialization' }
StPackageRelationGraphDiff >> initialize [
	packagesDiff := OrderedCollection new.
	dependentPackagesDiff := OrderedCollection new
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> lookUpForNewDependentPackages: newDependentPackages with: oldDependentPackages from: aPackage [

	| newDependent |
	newDependent := newDependentPackages reject: [ :package | oldDependentPackages includes: package ].
	newDependent do: [ :each | self addNewDependentPackage: each from: aPackage ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> lookUpForNewPackages [

	| newPackages |
	newPackages := newRelationGraph seenPackages reject: [ :package | oldRelationGraph includesSeenPackage: package ].
	newPackages do: [ :each | self addNewPackage: each ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> lookUpForRemovedDependentPackages: oldDependentPackages with: newDependentPackages from: aPackage [

	| removed |
	removed := oldDependentPackages reject: [ :package | newDependentPackages includes: package ].
	removed do: [ :each | self addRemovedDependentPackage: each from: aPackage ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> lookUpForRemovedPackages [
	| old |
	old := oldRelationGraph seenPackages reject: [ :each |  newRelationGraph includesSeenPackage: each ].
	old do: [ :each |
		self addRemovedPackage: each
		 ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> lookUpForUndeterminateDependentPackagesFrom: parent [
	| oldDependentPackages undeterminates |
	oldDependentPackages := (oldRelationGraph packageAt: parent packageName) dependentPackages.
	undeterminates := oldDependentPackages reject: [ :package | self removedDependentPackagesIncludes: package from: parent ].


	undeterminates do: [ :each | self addUndeterminateDependentPackage: each from: parent ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> lookUpForUndeterminatePackages [
	| undeterminates |
	undeterminates := oldRelationGraph seenPackages reject: [ :package | self removedPackagesIncludes: package ].
	undeterminates do: [ :each | self addUndeterminatePackage: each ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> make [
	self
		makePackagesDiff;
		makeDependentPackagesDiff
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> makeDependenciesDiff [
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> makeDependentPackagesDiff [
	"we're just looking at the package undeterminate"
	"every dependent packages are removed or new in older or new packages"
	self packagesDiffUnderteminate do: [ :item |
			self makeDependentPackagesDiffOn: item content.
		 ]
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> makeDependentPackagesDiffOn: aPackage [

	| oldDependentPackages newDependentPackages  |

	oldDependentPackages := (oldRelationGraph packageAt: aPackage packageName) dependentPackages.
	newDependentPackages := (newRelationGraph packageAt: aPackage packageName) dependentPackages.

	self lookUpForRemovedDependentPackages: oldDependentPackages with: newDependentPackages from: aPackage.
	self lookUpForNewDependentPackages: newDependentPackages with: oldDependentPackages from: aPackage.
	self lookUpForUndeterminateDependentPackagesFrom: aPackage
]

{ #category : 'searching' }
StPackageRelationGraphDiff >> makePackagesDiff [
	"lookUp for new and remove packages"

	self
		lookUpForRemovedPackages;
		lookUpForNewPackages;
		 lookUpForUndeterminatePackages
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> newRelationGraph [
	^ newRelationGraph
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> newRelationGraph: anObject [
	newRelationGraph := anObject
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> oldRelationGraph [
	^ oldRelationGraph
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> oldRelationGraph: anObject [
	oldRelationGraph := anObject
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packageDiffNamed: aName [
	^ self packagesDiff detect: [ :item | item content packageName = aName ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiff [
	^ packagesDiff
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffNew [
	^ packagesDiff select: [ :each | each isNew ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffNewSize [
	^ self packagesDiffNew size
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffRemoved [
	^ packagesDiff select: [ :each | each isRemoved ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffRemovedSize [
	^ self packagesDiffRemoved size
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffToDisplay [
	^ packagesDiff select: [ :each | each canBeDisplay ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffUnderteminate [
	^ packagesDiff select: [ :each | each isUnderteminate  ]
]

{ #category : 'accessing' }
StPackageRelationGraphDiff >> packagesDiffUnderteminateSize [
	^ self packagesDiffUnderteminate size
]

{ #category : 'testing' }
StPackageRelationGraphDiff >> removedDependentPackagesIncludes: aPackage from: parent [
	^ self dependentPackagesDiffRemoved
		detect: [ :package | package content = aPackage and: [ package parent = parent ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : 'testing' }
StPackageRelationGraphDiff >> removedPackagesIncludes: seenPackage [

	^ self packagesDiffRemoved detect: [ :each | each content = seenPackage ]
			ifFound: [ true ]
			ifNone: [ false ]
]
