"
It represents a setting category page with setting sections and settings. The page was selected from `StSettingsCategoriesPresenter` and it matches a `StSettingsCategoryItemPresenter`.

"
Class {
	#name : 'StSettingsPagePresenter',
	#superclass : 'StSettingsAbstractPresenter',
	#instVars : [
		'pageTitle',
		'settingDocPresenter',
		'settingDocLabel',
		'notebook',
		'settingTree'
	],
	#category : 'NewTools-SettingsBrowser-UI',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'UI'
}

{ #category : 'private' }
StSettingsPagePresenter >> activePage [

	| selectedPage |
	
	selectedPage := notebook selectedPage.
	selectedPage activePresenter
		ifNil: [ selectedPage retrievePresenter ].
	^ selectedPage activePresenter
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> addDefaultGeneralTabFrom: aStSettingNode [
	"Private - Add General Settings default"

	| generalSettingNode |
	
	generalSettingNode := StSettingNode with: PragmaSetting new.
	generalSettingNode item name: self generalTitle.
	generalSettingNode parentName: aStSettingNode name.
	notebook addPage: (SpNotebookPage new
				 icon: (self iconNamed: #smallQuestion);
				 presenterProvider: [ StSettingsNotebookPagePresenter on: generalSettingNode ];
				 title: self generalTitle;
				 yourself).
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> addHeaderForSettingsWithoutParent: aSpNotebookPage [
	"Private - We add a 'General' header (2nd level) for those nodes without parent other than the root"

	| generalSettingNode generalNodePresenter |

	generalSettingNode := self newGeneralSetting: aSpNotebookPage.
	generalNodePresenter := self
		                        newSectionNodePresenterFrom: generalSettingNode
		                        level: 2.
	self activePage 
		add: generalNodePresenter
		expand: false
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> addSearchResultTabFrom: resultStSettingNodes [
	"Private - Add a tab with search results from resultStSettingNodes in the receiver's notebook"

	| resultSearchNodes searchResultPage |
	
	resultSearchNodes := self collectResultNodes: resultStSettingNodes.
	searchResultPage := (notebook hasPageNamed: self resultsTitle)
		ifFalse: [ notebook addPageFirst: (self newResultPageOn: resultSearchNodes) ]
		ifTrue: [ (notebook pageNamed: self resultsTitle) presenterProvider: [ StSettingsNotebookPagePresenter onResults: resultSearchNodes ] ].
	notebook selectPage: searchResultPage.
	self notebook selectedPage resetContent.

]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> addTabsFrom: aStSettingNode [

	aStSettingNode allChildren do: [ :aSettingNode |
		| nodePresenter |
		(nodePresenter := self
			                  instantiate: aSettingNode presenterClass
			                  on: aSettingNode) hasChildren 
			ifTrue: [
				nodePresenter sectionTitleStyle: self sectionTitleString.
				notebook addPage: (SpNotebookPage new
					 icon: (self iconNamed: #smallQuestion);
					 presenterProvider: [ StSettingsNotebookPagePresenter on: aSettingNode ];
					 title: aSettingNode label;
					 yourself) ] ]
]

{ #category : 'private' }
StSettingsPagePresenter >> collectResultNodes: aCollection [
	"Private - Select and answer those nodes that do not represent section titles"
	
	| nodePresenters |
	nodePresenters := aCollection collect: [ :aSettingNode |
		                  self
			                  instantiate: aSettingNode presenterClass
			                  on: aSettingNode ].
	^ nodePresenters 
		reject: [ :nodePresenter | nodePresenter hasChildren ]

]

{ #category : 'initialization' }
StSettingsPagePresenter >> defaultInputPort [ 

	^ SpModelPort newPresenter: self

]

{ #category : 'layout' }
StSettingsPagePresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: pageTitle expand: false;
		add: (SpPanedLayout newVertical 
			positionOfSlider: 0.85;
			add: notebook;
			add: (SpBoxLayout newTopToBottom
				spacing: 5;
				add: settingDocLabel expand: false;
				add: settingDocPresenter;
				yourself);
			yourself);
		yourself
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> generalTitle [

	^ 'General'
]

{ #category : 'initialization' }
StSettingsPagePresenter >> initializePresenters [

	pageTitle := self newLabel.
	notebook := self newNotebook
		            whenSelectedPageChangedDo: [ :presenter | self updateSelectedPage: presenter ];
		            yourself.
	settingDocLabel := self newLabel
		                   addStyle: 'settingDocTitle';
		                   yourself.
	settingDocPresenter := self newText
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> newGeneralSetting: aSpNotebookPage [

	| currentParent generalSettingNode |
	
	currentParent := aSpNotebookPage activePresenter parentNode.
	generalSettingNode := StSettingNode with: PragmaSetting new.
	generalSettingNode item name: self generalTitle.
	generalSettingNode parentName: (currentParent ifNotNil: [ currentParent name ]).
	^ generalSettingNode
]

{ #category : 'instance creation' }
StSettingsPagePresenter >> newResultPageOn: aCollection [ 

	^ SpNotebookPage new
		 icon: (self iconNamed: #smallQuestion);
		 presenterProvider: [ StSettingsNotebookPagePresenter onResults: aCollection ];
		 beCloseable;				
		 title: self resultsTitle;
		 yourself
]

{ #category : 'callbacks' }
StSettingsPagePresenter >> newSectionNodePresenterFrom: aSettingNode level: anInteger [
	"Private - This is a temporary method until finding a proper solution for 'hand-wired' sections, since some settings declarations are not grouped"

	| nodePresenter |
	nodePresenter := self
		                 instantiate: StSettingSectionPresenter
		                 on: aSettingNode.
	nodePresenter sectionTitleStyle: self sectionTitleString , anInteger asString.
	^ nodePresenter
]

{ #category : 'initialization' }
StSettingsPagePresenter >> notebook [

	^ notebook 
	
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> resultsTitle [

	^ 'Results'
]

{ #category : 'callbacks' }
StSettingsPagePresenter >> selectFirstPage [
	
	self notebook selectPageIndex: 1.
	self updateSelectedPage: self notebook selectedPage.
]

{ #category : 'accessing - model' }
StSettingsPagePresenter >> setModel: aNode [ 
	"Private - Set the receiver's content iterating recursively starting from aNode"

	settingTree := aNode model childrenOf: aNode.
	pageTitle 
		label: aNode label;
		addStyle: 'pageTitle'.
	notebook removeAll.
	self updatePages: aNode.

]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> updatePages: aStSettingNode [
	"Private - Recursively iterate aStSettingNode children using anInteger as 'level' indicator for title styling purposes"

	self addDefaultGeneralTabFrom: aStSettingNode.
	self addTabsFrom: aStSettingNode.
]

{ #category : 'callbacks' }
StSettingsPagePresenter >> updatePresenterGeneralNodes: aCollection [

	| nodePresenter |
	aCollection do: [ :settingNode |
		nodePresenter := self newNodePresenterFrom: settingNode level: 2.
		self activePage add: nodePresenter expand: false ]
]

{ #category : 'callbacks' }
StSettingsPagePresenter >> updatePresenterTree: aStSettingNode level: anInteger [
	"Private - Recursively iterate aStSettingNode children using anInteger as 'level' indicator for title styling purposes"

	aStSettingNode allChildren do: [ :aSettingNode |
		| nodePresenter |
		nodePresenter := self
			                 newNodePresenterFrom: aSettingNode
			                 level: anInteger.
		self activePage add: nodePresenter expand: false.
		self updatePresenterTree: aSettingNode level: anInteger + 1 ]
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> updateSelectedPage: aSpNotebookPage [
	"Private - Update the receiver's notebook with aSpNotebookPage. The first time the notebook is opened, a #selectedPage event is triggered and aSpNotebookPage will be nil"

	aSpNotebookPage ifNotNil: [ 
		aSpNotebookPage activePresenter ifNotNil: [ : activePresenter | activePresenter removeAll ].
		self updateSelectedSpecialCases: aSpNotebookPage.
		self updateSelectedPageTree: aSpNotebookPage ]
]

{ #category : 'private' }
StSettingsPagePresenter >> updateSelectedPageTree: aSpNotebookPage [ 

	aSpNotebookPage activePresenter 
		ifNil: [ aSpNotebookPage retrievePresenter ]
		ifNotNil: [ : activePresenter |
			activePresenter parentNode
				ifNotNil: [ : tabNode | self updatePresenterTree: tabNode level: 2 ]
				ifNil: [ self updatePresenterTree: aSpNotebookPage activePresenter level: 2  ] ]
]

{ #category : 'callbacks - tabs' }
StSettingsPagePresenter >> updateSelectedSpecialCases: aSpNotebookPage [ 
	"Do not add a 'General' header if we are already in the General tab" 
	
	aSpNotebookPage title = self resultsTitle
		ifFalse: [ 
			aSpNotebookPage title = self generalTitle
				ifFalse: [ self addHeaderForSettingsWithoutParent: aSpNotebookPage ]
				ifTrue: [ self updatePresenterGeneralNodes: (settingTree reject: [ : node | node hasChildren ]) ] ]
]

{ #category : 'callbacks' }
StSettingsPagePresenter >> updateSetting: labelString helpText: settingHelpString [

	settingDocLabel label: labelString.
	settingDocPresenter text: settingHelpString.
]
