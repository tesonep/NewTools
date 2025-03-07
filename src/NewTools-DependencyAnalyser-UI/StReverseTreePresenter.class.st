"
A DAPackageAnalyzerReverseTreeModel shows all users from a set of packages. Also you can see all type of the dependency, and browse them.

The presenter is initialized with a relation graph of package dependencies, with all the dependencies already compute.
"
Class {
	#name : 'StReverseTreePresenter',
	#superclass : 'StPackageTreePresenter',
	#instVars : [
		'relationGraph',
		'packageLabel'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StReverseTreePresenter class >> onRelationGraph: aRelationGraph [
	^ self on: aRelationGraph
]

{ #category : 'private' }
StReverseTreePresenter >> buildRoots [
	| collectionOfWrapper |
	collectionOfWrapper := relationGraph allDependentPackagesFromSeenPackages
		collect: [ :package | package asDependentPackageWrapperOn: relationGraph ].

	self tree roots: (self nodesFor: collectionOfWrapper asSortedCollection).
	self updatePackageLabel
]

{ #category : 'initialization' }
StReverseTreePresenter >> connectPresenters [

	super connectPresenters.
	tree whenSelectedItemChangedDo: [ :item |
		item ifNotNil: [
			self tree selectedItem selectInBrowser ] ]
]

{ #category : 'layout' }
StReverseTreePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: buttonRefresh expand: false;
		  add: packageLabel expand: false;
		  add: tree;
		  yourself
]

{ #category : 'initialization' }
StReverseTreePresenter >> dependencyActions [

	^ SpActionGroup new 
		beDisplayedAsGroup;
		addActionWith: [ :action | action 
			name: 'Browse dependencies from class';
			actionEnabled: [ self areClassToDependencyNodes: self selectedItemsFromTree ];
			action: [ self doOpenTreeForSelection ] ];
		yourself
]

{ #category : 'actions' }
StReverseTreePresenter >> doOpenCycleDetection [
	| selectedPackageNames |
	
	selectedPackageNames := self selectedItemsFromTree 
		collect: [ :packageNode | packageNode packageName ].
	
	(StCycleDetectionPresenter onPackagesNamed: selectedPackageNames) open
]

{ #category : 'actions' }
StReverseTreePresenter >> doOpenPackagesDepensencies [
	| selectedPackageNames |
				
	selectedPackageNames := self selectedItemsFromTree 
		collect: [ :packageNode | packageNode packageName ].
	
	(StPackageDependenciesPresenter onPackagesNamed: selectedPackageNames) open
]

{ #category : 'actions' }
StReverseTreePresenter >> doOpenTreeForSelection [
	| namesOfSelected |

	namesOfSelected := self selectedItemsFromTree 
		collect: [ :package | package content theClass ].
	self openTreeFor: namesOfSelected
]

{ #category : 'initialization' }
StReverseTreePresenter >> initializePresenters [

	super initializePresenters.

	tree actions: self treeActions.
	packageLabel := self newLabel label: 'Analysis of packages'.
	self buildRoots
]

{ #category : 'private' }
StReverseTreePresenter >> nodesFor: anItemList [
	^ anItemList collect:
		[ :each |
		StReversePackageNode new
						content: each;
						treeModelParent: self;
						browser: self browser;
						cycle: false;
						yourself ]
]

{ #category : 'initialization' }
StReverseTreePresenter >> packageActions [
	
	^ SpActionGroup new
		beDisplayedAsGroup;
		addActionWith: [ :action | action 
			name: 'Browse scoped references';
			actionEnabled: [ self arePackageNodes: self selectedItemsFromTree ];
			action: [ self doOpenPackagesDepensencies ] ];
		addActionWith: [ :action | action 
			name: 'Find cycles among packages';
			actionEnabled: [ 
				(self arePackageNodes: self selectedItemsFromTree)
				and: [ self selectedItemsFromTree size > 1 ] ];
			action: [ self doOpenCycleDetection ] ];
		yourself
]

{ #category : 'actions' }
StReverseTreePresenter >> refresh [

	self relationGraph refreshGraph.
	self buildRoots
]

{ #category : 'accessing' }
StReverseTreePresenter >> relationGraph [
	^ relationGraph
]

{ #category : 'initialization' }
StReverseTreePresenter >> setModelBeforeInitialization: aRelationGraph [
	relationGraph := aRelationGraph
]

{ #category : 'initialization' }
StReverseTreePresenter >> treeActions [
	| menu |

	menu := SpActionGroup new.
	menu add: self packageActions.
	menu add: self dependencyActions.
	menu add: (SpDynamicActionGroup new 
		beDisplayedAsSubMenu;
		name: 'Node';
		description: 'Special actions for node';
		with: [ :aGroup | 
			self selectedItemsFromTree size = 1 
				ifTrue: [ self selectedItemsFromTree first addMenuActionsOn: aGroup ] ];
		yourself).
	
	^ menu
	
]

{ #category : 'private' }
StReverseTreePresenter >> updatePackageLabel [
	packageLabel label: 'Analysis of ' , self tree roots size asString , ' package(s)'
]

{ #category : 'accessing' }
StReverseTreePresenter >> windowTitle [

	^ 'Package Dependencies Reverse Analysis'
]
