"
A PDPackageDetectCycleTreeModel shows all cycles among packages from a graph of dependencies.
"
Class {
	#name : 'StCycleDetectionTreePresenter',
	#superclass : 'StPackageTreePresenter',
	#instVars : [
		'analysis',
		'cycles',
		'cyclesLabel',
		'filter',
		'buttonSort'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'specs' }
StCycleDetectionTreePresenter class >> defaultPreferredExtent [

	^ 1000@600
]

{ #category : 'instance creation' }
StCycleDetectionTreePresenter class >> onPackagesMatch: match [
	^ (self onPackagesNamed:
			(self packageOrganizer packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) )
]

{ #category : 'instance creation' }
StCycleDetectionTreePresenter class >> onPackagesNamed: aCollection [
	self flag: #IncreaseTechnicalDebt.
	"The flow is BAD AND WRONG! 
	We should not explicit use StPharoApplication current this is a bad practice. Now I have no idea how to do it otherwise. So let us propagate bad practices.
	You like debt: here it is"

	^ (self newApplication: StPharoApplication current) 
		initializeWithPackageName: aCollection;
		yourself
]

{ #category : 'instance creation' }
StCycleDetectionTreePresenter class >> system [

	^ self onPackagesNamed: (self packageOrganizer packages collect: [ :package | package name asString ])
]

{ #category : 'specs' }
StCycleDetectionTreePresenter class >> title [

	^ 'Cycles analysis'
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> analysis [
	^ analysis
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> analysis: anObject [
	analysis := anObject
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> browser: anObject [
	browser := anObject
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> buildRoots [
	| roots |
	roots := cycles collect: [ :cycle |
		StCycleNode new
			content: cycle;
			treeModelParent: self;
			browser: self browser;
			cycle: true ].
	self tree roots: roots.

	cyclesLabel
		label: 'Analysis of ' , self cycles size asString , ' cycles'
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> cycles [
	^ cycles
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> cycles: aCollectionOfCycles [
	cycles := aCollectionOfCycles sorted: [ :a :b | a size > b size ].
	self buildRoots
]

{ #category : 'layout' }
StCycleDetectionTreePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
				add: buttonSort;
				add: buttonRefresh;
			yourself)
			expand: false;
		add: 'Analysis of cycles' expand: false;
		add: tree;
		yourself
]

{ #category : 'initialization' }
StCycleDetectionTreePresenter >> doSelectPackageAsRightDependency [
	| item method |

	item := tree selectedItem.
	method := item content.
	(TheManifestBuilder of: self packageUnderAnalysis packageManifest)
		addManuallyResolvedDependency: method package name.
	"TODO: run the analysis again"
]

{ #category : 'protocol' }
StCycleDetectionTreePresenter >> extent [
	^ 1000@600
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> filter [
	^ filter
]

{ #category : 'filtering' }
StCycleDetectionTreePresenter >> filterWithPackages [

	self cycles: (self analysis cyclesWithAtLeast: filter)
]

{ #category : 'filtering' }
StCycleDetectionTreePresenter >> filterWithPackages: aCollectionOfPDPackage [
	filter := aCollectionOfPDPackage.
	self cycles: (self analysis cyclesWithAtLeast: filter)
]

{ #category : 'initialization' }
StCycleDetectionTreePresenter >> initializePresenters [

	super initializePresenters.

	tree addActionWith: [ :action | action
		name: 'Select this package as the right dependency';
		actionEnabled: [ self selectedItemIsMethod  ];
		action: [ self doSelectPackageAsRightDependency ] ].

	cyclesLabel := self newLabel
			label: 'Analysis of cycles'.

	buttonSort := self newButton
		help: 'Sort cycles by the number of packages involved in the cycle';
		label: 'Sort by length';
		action: [ self reversedRoots  ]
]

{ #category : 'initialization' }
StCycleDetectionTreePresenter >> initializeWithPackageName: aCollection [

	self analysis:  (StPackageCycleDetector onPackagesNamed: aCollection) runAlgorithm.

	self cycles: self analysis cycles
]

{ #category : 'actions' }
StCycleDetectionTreePresenter >> refresh [
	self analysis refresh.
	self filter ifNil: [ self cycles: self analysis cycles ]
		ifNotNil: [ self cycles: (self analysis cyclesWithAtLeast: filter) ].
	self buildRoots
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> reversedRoots [
	self tree roots: (self tree roots reversed)
]

{ #category : 'initialization' }
StCycleDetectionTreePresenter >> selectedItemIsMethod [
	| item |
	
	item := tree selectedItem.
	item ifNil: [ ^ false ].
	
	^ item content isKindOf: CompiledMethod
]

{ #category : 'accessing' }
StCycleDetectionTreePresenter >> windowTitle [

	^ 'Cycles analysis'
]
