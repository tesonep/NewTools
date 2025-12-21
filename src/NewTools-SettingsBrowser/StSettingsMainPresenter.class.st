"
The Settings Browser it is organized in three main Spec presenters:

- A toolbar which holds operations to be performed (mainly searching), presented by `StSettingsToolbarPresenter`.
- A presenter for ""main categories"", presented by `StSettingsCategoriesPresenter`.
- And a ""details presenter"", presented by `StSettingsPagePresenter`, instantiated when the users selects a main category.

The class side holds application assets (icons and styles) and initializers for the Settings Browser.

"
Class {
	#name : 'StSettingsMainPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'toolbarPresenter',
		'detailsPresenter',
		'mainCategoriesPresenter',
		'buttonBarPresenter',
		'exporter',
		'categoriesPresenter'
	],
	#category : 'NewTools-SettingsBrowser-UI',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'UI'
}

{ #category : 'accessing' }
StSettingsMainPresenter class >> defaultPreferredExtent [

	 ^ 1200 @ 700
]

{ #category : 'world menu' }
StSettingsMainPresenter class >> menuSettingsBrowserCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'New Settings Browser')
		parent: #NewToolsMenu;
		label: 'New Settings Browser';
		action: [ (self newApplication: self currentApplication) open ];
		iconName: self taskbarIconName;
		help: 'New Settings Browser';
		order: 3
]

{ #category : 'initialization' }
StSettingsMainPresenter >> connectPresenters [ 

	"mainCategoriesPresenter 
		transmitTo: detailsPresenter
		transform: [ : aCategoryItemPresenter | aCategoryItemPresenter node ]
		postTransmission: [ : selectedPage | selectedPage selectFirstPage  ]"
		
		
	categoriesPresenter transmitTo: detailsPresenter
]

{ #category : 'transmission' }
StSettingsMainPresenter >> defaultInputPort [ 

	^ SpListItemsPort newPresenter: detailsPresenter

]

{ #category : 'layout' }
StSettingsMainPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: (SpPanedLayout newHorizontal
			positionOfSlider: 250;
			add: (SpBoxLayout newTopToBottom
				add: toolbarPresenter expand: false;
				add: categoriesPresenter;
				yourself);
			add: detailsPresenter;
			yourself);
		  add: buttonBarPresenter expand: false;
		  yourself
]

{ #category : 'transmission' }
StSettingsMainPresenter >> defaultOutputPort [ 

	^ mainCategoriesPresenter
]

{ #category : 'initialization' }
StSettingsMainPresenter >> exportSettings [
	| nodes actions |

	nodes := self settingsTree nodeList.
	actions := nodes 
		collect: [ : e | e item exportSettingAction ]
		thenReject: [ : e | e isNil ].
		
	self exporter exportAllSettings: actions.
	self inform: 'Settings were exported to ' , self exporter exportedFileFullName.
	buttonBarPresenter enable
]

{ #category : 'accessing' }
StSettingsMainPresenter >> exporter [

	^ exporter
]

{ #category : 'searching' }
StSettingsMainPresenter >> followPath: aStSettingNode in: aCollection [

	^ aStSettingNode hasParent
		ifTrue: [ (self followPath: aStSettingNode parentNode in: aCollection) ]
		ifFalse: [ aCollection add: aStSettingNode ].

]

{ #category : 'initialization' }
StSettingsMainPresenter >> initialize [

	super initialize.
	exporter := StSettingsExporter new
]

{ #category : 'initialization' }
StSettingsMainPresenter >> initializeButtonBar [

	buttonBarPresenter := self newPresenter
		layout: (SpBoxLayout newLeftToRight
			hAlignEnd;
			vAlignCenter;
			add: (self newButton
				addStyle: 'large';
				icon: (self iconNamed: #openFromUrl);
				label: 'Load';
				help: 'Load settings from a file';
				action: [ self loadSettings ];
				enabled: self settingsTree hasSettingsFile;
				yourself);
			add: (self newButton
				icon: (self application iconNamed: #save);
				label: 'Export';
				help: 'Save settings into a file';
				action: [ self exportSettings ];
				yourself);
			add: (self newButton
				icon: (self iconNamed: #cancel);
				action: [ self delete ];
				label: 'Cancel';
				yourself);
			yourself);
		yourself
]

{ #category : 'initialization' }
StSettingsMainPresenter >> initializeFocus [

	self focusOrder 
		add: toolbarPresenter;
		add: mainCategoriesPresenter;
		add: detailsPresenter
]

{ #category : 'initialization' }
StSettingsMainPresenter >> initializePresenters [

	toolbarPresenter := self instantiate: StSettingsToolbarPresenter on: self.
	mainCategoriesPresenter := self instantiate: StSettingsCategoriesPresenter on: self.
	
	categoriesPresenter := self newEasyTreeListView
		display: [ :aNode | aNode label ];
		children: [ :aNode | 
			(aNode level < 2) 
				ifTrue: [ self sortNodes: (aNode allChildren select: [ :each | each hasChildren ]) ]
				ifFalse: [ #() ] ];
		yourself.
	
	detailsPresenter := self instantiate: StSettingDetailPresenter.
	
	self initializeButtonBar.
	self initializeFocus.
]

{ #category : 'loading' }
StSettingsMainPresenter >> loadSettings [
	"Load the settings from the system settings file, if exists"

	self settingsTree settingsFileDirectory
		ifNotNil: [ : settingsDirectory | 
			settingsDirectory hasFiles 
				ifTrue: [ self loadSettingsFrom: (self selectDialog: settingsDirectory files) ]
				ifFalse: [ self inform: 'No settings files were found in the settings directory' ] ]
]

{ #category : 'loading' }
StSettingsMainPresenter >> loadSettingsFrom: aFileReference [ 

	self settingsTree persistence fileReference: aFileReference.
	self settingsTree updateSettingNodes.
	self inform: 'Settings were loaded from ' , aFileReference fullName
]

{ #category : 'initialization' }
StSettingsMainPresenter >> pagePresenter [ 

	^ detailsPresenter
]

{ #category : 'execution' }
StSettingsMainPresenter >> selectDialog: fileReferneces [

	^ SpSelectDialog new 
		title: 'Settings Browser Selector';
		label: 'Select a Stored Settings File';
		items: fileReferneces;
		display: [ :each | each basename ];
		displayIcon: [ :each | self iconNamed: each systemIconName ];
		openModal.

]

{ #category : 'accessing' }
StSettingsMainPresenter >> settingsTree [
	"Answer the receiver's <StSettingsTree>, the settings model"

	^ self application 
		propertyAt: #settingsTree
		ifAbsentPut: [ StSettingsTree new ]
]

{ #category : 'private' }
StSettingsMainPresenter >> sortNodes: aCollection [ 

	^ aCollection sorted: #order ascending, #label ascending
]

{ #category : 'initialization' }
StSettingsMainPresenter >> updatePresenter [

	categoriesPresenter 
		roots: (self sortNodes: self settingsTree treeRoots);
		expandRoots
]

{ #category : 'initialization' }
StSettingsMainPresenter >> windowTitle [ 

	^ 'Settings Browser'
]
