"
I am a panel in the ProfilerPresenter containing the profiling process results together with parameters to filter these results
"
Class {
	#name : 'StProfilerResultsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'treeTable',
		'viewModel',
		'codePresenter',
		'browseButton',
		'treeDropList',
		'expandAllButton',
		'collapseAllButton',
		'thresholdFilterInput',
		'thresholdExpandInput',
		'navigationToolbar',
		'reportButton',
		'showAsRootButton'
	],
	#category : 'NewTools-ProfilerUI-Presenters',
	#package : 'NewTools-ProfilerUI',
	#tag : 'Presenters'
}

{ #category : 'private' }
StProfilerResultsPresenter >> doItNode [

	| talliesPathToExpand actualNodeInTree |
	talliesPathToExpand := Stack withAll:
		                       (viewModel tallyRoot
			                        detectPathOfMethodSelector: 'DoIt'
			                        maxDepth: 10).

	talliesPathToExpand ifEmpty: [ ^ nil ].

	actualNodeInTree := nil.

	treeTable expandAllSuchThat: [ :item |
		(talliesPathToExpand isNotEmpty and: [
			 item = talliesPathToExpand top and: [ item hasContents ] ])
			ifTrue: [
				talliesPathToExpand pop.
				talliesPathToExpand ifEmpty: [ actualNodeInTree := item ].
				true ]
			ifFalse: [ false ] ].

	^ actualNodeInTree
]

{ #category : 'event handling' }
StProfilerResultsPresenter >> handleProfilingFinished [

	| doItNode |
	self defer: [
		self enabled: true.

		viewModel showLeavesOnly ifFalse: [ "select do it node and expand tree"
			doItNode := self doItNode.
			doItNode
				ifNil: [
					self inform:
						'The excecution time was too short! No measurements taken' ]
				ifNotNil: [
					treeTable selectPath: doItNode path scrollToSelection: true.
					viewModel setTallyRoot: doItNode ] ].
		viewModel announcer announce:
			StProfilingResultsDisplayedAnnouncement new ]
]

{ #category : 'event handling' }
StProfilerResultsPresenter >> handleProfilingStarted [
	self enabled: false.
	navigationToolbar reset
]

{ #category : 'event handling' }
StProfilerResultsPresenter >> handleSelectionChanged [
	| navButton node |
	node := treeTable selectedItem.

	node
		ifNil: [
			browseButton disable.
			showAsRootButton disable.
			codePresenter methodOrBlock: nil ]
		ifNotNil: [
			browseButton enable.
			showAsRootButton enable.
			codePresenter methodOrBlock: node methodOrBlock.
			 ].

	navButton := navigationToolbar selectedItem.
	navButton ifNil: [ ^ self ].
	navButton selectedObject: node
]

{ #category : 'event handling' }
StProfilerResultsPresenter >> handleTreeRootChanged: event [

	| nodeToSelect pathToSelect |
	self assert: event item == viewModel tallyRoot.

	treeTable roots: viewModel rootItems.
	self assert: treeTable selectedItem isNil.

	navigationToolbar setSelectedItem:
		(navigationToolbar ensureItemWith: viewModel tallyRoot).

	nodeToSelect := navigationToolbar selectedItem
		                ifNil: [ event item ]
		                ifNotNil: [ :btn |
		                btn selectedObject ifNil: [ event item ] ].

	pathToSelect := viewModel showLeavesOnly
		                ifTrue: [ nodeToSelect path ]
		                ifFalse: [ nodeToSelect relativePath ].

	viewModel showLeavesOnly ifFalse: [
		treeTable expandAllSuchThat: [ :node |
			node weightToRoot asFloat closeTo: 100.0 ].
		treeTable expandPath: pathToSelect ].

	treeTable selectPath: pathToSelect scrollToSelection: true
]

{ #category : 'initialization' }
StProfilerResultsPresenter >> initializeActions [

	| pres |
	treeTable
		whenSelectedItemChangedSend: #handleSelectionChanged
		to: self.

	"Report"
	reportButton action: [
		pres := SpTextPresenter new
			        text: viewModel report;
			        open.
		pres withWindowDo: [ :w | w title: 'Profiling Report' ] ].
	collapseAllButton action: [
		treeTable collapseAll.
		treeTable takeKeyboardFocus ].
	"Configuration section actions"

	expandAllButton action: [
		treeTable expandAll.
		treeTable takeKeyboardFocus ].

	thresholdExpandInput whenTextChangedDo: [ :text |
		text asInteger ifNotNil: [ treeTable expandNodesOver: text asNumber ] ].

	thresholdFilterInput whenTextChangedDo: [ :text |
		text asInteger ifNotNil: [ treeTable hideNodesUnder: text asNumber ] ].

	treeDropList whenSelectedItemChangedDo: [ :item |
		viewModel showLeavesOnly: item value ]
]

{ #category : 'initialization' }
StProfilerResultsPresenter >> initializePresenters [

	| h |
	h := self class toolbarHeight.

	self layout: (SpPanedLayout newTopToBottom
			 positionOfSlider: 50 percent;
			 add: (SpBoxLayout newTopToBottom
					  add: (navigationToolbar := self newProfilerToolbar) height: h;
					  add: (treeTable := self newProfilerTreeTable);
					  yourself);
			 add: (SpBoxLayout newTopToBottom
					  add: self newConfigurationSectionLayout height: h * 2.5;
					  add: (codePresenter := self newProfilerCode);
					  add: (SpBoxLayout newLeftToRight
							   add: (reportButton := self newReportButton)
							   withConstraints: [ :constraints |
								   constraints
									   bePlacedAtStart;
									   fill: true;
									   expand: false ];
							   addLast: (showAsRootButton := self newShowAsRootButton);
							   addLast: (browseButton := self newBrowseButton))
					  height: h;
					  yourself);
			 yourself).

	self initializeActions
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newBrowseButton [

	^ self newButton
		  icon: (self iconNamed: #browse);
		  label: 'Browse';
		  disable;
		  action: [ treeTable selectedItem browseItem ];
		  yourself
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newConfigurationSectionLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: (treeDropList := self newTreeVisualizationDropList);
				   add: (expandAllButton := self newButton
						                       label: 'Expand All';
						                       icon: (self iconNamed: #windowMenu))
				   width: 100;
				   add: (collapseAllButton := self newButton
						                         label: 'Collapse All';
						                         icon: (self iconNamed: #windowMinimize))
				   width: 100;
				   yourself);
		  add: (SpBoxLayout newLeftToRight
				   add: (self newLabel label: 'Hide nodes under: ') width: 125;
				   add: (thresholdFilterInput := self newThresholdFilterInput)
				   width: 55;
				   add: (self newLabel label: '%') width: 25;
				   yourself);
		  add: (SpBoxLayout newLeftToRight
				   add: (self newLabel label: 'Expand nodes over: ') width: 125;
				   add: (thresholdExpandInput := self newThresholdExpandInput)
				   width: 55;
				   add: (self newLabel label: '%') width: 25;
				   yourself);
		  yourself
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newProfilerCode [

	^ self instantiate: StProfilerCodePresenter
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newProfilerNumberInput [
	^ self instantiate: StProfilerNumberInput
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newProfilerToolbar [

	^ self instantiate: StProfilerToolbarPresenter
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newProfilerTreeTable [

	^ StProfilerTreeTablePresenter on: viewModel
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newReportButton [

	^ self newButton
		icon: (self iconNamed: #recentMessages);
		label: 'Full Report';
		disable;
		yourself
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newShowAsRootButton [

	^ self newButton
		  icon: (self iconNamed: #redo);
		  label: 'Show node as root';
		  action: [ viewModel setTallyRoot: treeTable selectedItem ];
		  disable;
		  yourself
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newThresholdExpandInput [

	^ self newProfilerNumberInput
		  help: 'Only nodes with a percentage of time greater than this threshold will be expanded';
		  number: 0;
		  yourself
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newThresholdFilterInput [

	^ self newProfilerNumberInput
		  help: 'Only nodes with a percentage of time greater than this threshold will be shown';
		  number: viewModel showNodeThreshold;
		  yourself
]

{ #category : 'private - factory' }
StProfilerResultsPresenter >> newTreeVisualizationDropList [
	| items |
	items := {
		         ('Full tree' -> false).
		         ('Leaves only' -> true) }.

	^ self newDropList
		                help: 'Results visualization mode';
		                items: items;
		                selectItem: (viewModel showLeavesOnly
				                 ifTrue: [ items at: 2 ]
				                 ifFalse: [ items at: 1 ]);
		                display: [ :assoc | assoc key ];
		                yourself
]

{ #category : 'accessing - model' }
StProfilerResultsPresenter >> setModelBeforeInitialization: aDomainObject [

	viewModel := aDomainObject
]

{ #category : 'subscription' }
StProfilerResultsPresenter >> subscribeOnProfilingAnnouncements [

	viewModel announcer
		when: StProfilingStartedAnnouncement send: #handleProfilingStarted to: self;
		when: StProfilingFinishedAnnouncement send: #handleProfilingFinished to: self;
		when: StProfilerResultsTreeRootChangedAnnouncement send: #handleTreeRootChanged: to: self
]

{ #category : 'subscription' }
StProfilerResultsPresenter >> unsubscribeFromProfilingAnnouncements [

	viewModel announcer unsubscribe: self
]

{ #category : 'accessing' }
StProfilerResultsPresenter >> viewModel [

	^ viewModel
]
