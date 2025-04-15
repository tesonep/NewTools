"
I'm a presenter showing StObjectTranscriptLogger log elements. 


```
StObjectTranscriptPresenter open
 
StObjectTranscriptPresenter openWithLogger: StObjectTranscripLogger instance
```

To open from another presenter use the following expression

```
(self application toolNamed: #objectTranscript) open
```


You can show/hide the inspector and the inspector can either display the currently selected log entry or the complete list so that we can perform collection operations for complex filters


```
	| cb |
	StObjectTranscriptLogger start.
	cb := self open.
	'Pharo is super nice!' emit.
``` 




"
Class {
	#name : 'StObjectTranscriptPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'logList',
		'recordsInspector',
		'selectedRecordInspector',
		'logger',
		'inspectSelectedItem',
		'showInspector',
		'isOpened',
		'tabLayout'
	],
	#classVars : [
		'ShowInspector'
	],
	#category : 'NewTools-ObjectTranscript',
	#package : 'NewTools-ObjectTranscript'
}

{ #category : 'accessing' }
StObjectTranscriptPresenter class >> defaultPreferredExtent [
	"Answer the desired extent for the receiver when it is first opened on the screen.  "

	^ 550 @ 850
		
]

{ #category : 'accessing' }
StObjectTranscriptPresenter class >> example [
	"StObjectTranscriptLogger start.
	
	
	self example"
	
	| cb |
	StObjectTranscriptLogger start.
	cb := self new.
	cb logger: StObjectTranscriptLogger instance.
	'this is a message only interesting from the logger domain' emit.
	cb open.
	^ cb
]

{ #category : 'accessing' }
StObjectTranscriptPresenter class >> example2 [
	"self example2"
	
	self open. 
	'Hello Pharo is cool,' emit.
	
]

{ #category : 'instance creation' }
StObjectTranscriptPresenter class >> open [ 
	"Make sure that the object transcript logger is on and open a presenter on it."
	<script>
	
	StObjectTranscriptLogger start.
	^ self openWithLogger: StObjectTranscriptLogger instance
]

{ #category : 'instance creation' }
StObjectTranscriptPresenter class >> openWithLogger: aLogger [

	^ self new logger: aLogger; open 

	
]

{ #category : 'registration' }
StObjectTranscriptPresenter class >> registerToolsOn: registry [

	registry register: self as: #objectTranscript

]

{ #category : 'settings' }
StObjectTranscriptPresenter class >> settings: aBuilder [

	<systemsettings>

	(aBuilder setting: #objectTranscript)
		parent: #tools;
		selector: #showInspector;
		default: true;
		label: 'Display the inspector part';
		description: 'The object transcript supports the in place inspector of log entities. This preference enables it by default';
		target: self
]

{ #category : 'settings' }
StObjectTranscriptPresenter class >> showInspector [

	^ ShowInspector
]

{ #category : 'settings' }
StObjectTranscriptPresenter class >> showInspector: aBoolean [

	ShowInspector := aBoolean
]

{ #category : 'registration' }
StObjectTranscriptPresenter class >> worldMenuOn: aBuilder [

"Place it should go when its finished"
"	
	<worldMenu>
	(aBuilder item: #Browse)
		parent: #InputOutput;
		label: 'Object Transcript';
		order: 3;
		iconName: #transcript;
		help: 'Tool to be able to see logs in this instance of Pharo.';
		action: [ self open ]
"

	<worldMenu>
	(aBuilder item: #n)
		parent: #NewToolsMenu;
		label: 'Object Transcript';
		order: 4;
		iconName: #transcript;
		help: 'Tool to be able to see logs in this instance of Pharo.';
		action: [ self open ]
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> addActions [

	logList
		addActionWith: [ :item | item
			dynamicName: [
				showInspector 
					ifTrue: ['Hide inspector' ]
					ifFalse: ['Show inspector' ] ];
			action: [ self showInspector: showInspector not ] ];
		addActionWith: [ :item | item
			name: 'Flush entities';
			action: [ self flush ]];
		addActionWith: [ :item | item
			dynamicName: [
				self isLoggerRunning 
					ifTrue: ['Stop logger' ]
					ifFalse: ['Start logger' ] ];
			action: [ self switchLogger ] ]
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> connectPresenters [
	
	logList whenSelectionChangedDo: [ :aSelection | self performSelection: aSelection ]
	
]

{ #category : 'layout' }
StObjectTranscriptPresenter >> defaultLayout [
	
	^ showInspector 
		ifTrue: [ self withInspectorLayout ]
		ifFalse: [ self withoutInspectorLayout ]
]

{ #category : 'customization' }
StObjectTranscriptPresenter >> defaultShowInspector [

	^ ShowInspector ifNil: [ ShowInspector := true ]
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> flush [

	logger reset.
	self populateItemsFrom: logger.
	tabLayout select: recordsInspector
	
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initialize [

	super initialize. 
	inspectSelectedItem := true.
	showInspector := self defaultShowInspector
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initializeLogList [

	logList 
		beResizable;
		addColumn: (SpStringTableColumn new
			width: 180;
			title: 'Timestamp';
			evaluated:  [ :each | each timestamp ];
			yourself);
		addColumn: (SpStringTableColumn new
			width: 150;
			title: 'Name';
			evaluated:  [ :each | each name ];
			yourself);
		addColumn: (SpStringTableColumn new
			title: 'Contents';
			evaluated:  [ :each | self printOneLineContents: each  ];
			yourself)
	
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initializePresenters [

	logList := self newEasyColumnView.
	self initializeLogList.
	recordsInspector := self instantiate: StInspectorPresenter. 
	selectedRecordInspector := self instantiate: StInspectorPresenter.
	
	self addActions
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [ 
		isOpened := true ].
	aWindowPresenter whenClosedDo: [ 
		self removeFromLogger ]
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> inspect: anObject inspector: aPresenter [
	
	aPresenter model: anObject asInspectorModel
		
]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> isLoggerRunning [

	^ logger isRunning
]

{ #category : 'testing' }
StObjectTranscriptPresenter >> isOpened [ 
	
	^ isOpened ifNil: [ isOpened := false ]
]

{ #category : 'private' }
StObjectTranscriptPresenter >> logList [ 
	
	^ logList 
]

{ #category : 'private' }
StObjectTranscriptPresenter >> logger [

	^ logger
]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> logger: aLogger [
	
	aLogger ifNil: [ ^ self ].
	logger := aLogger.
	logger addAsClient: self. 
	self populateItemsFrom: logger
	
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> performSelection: aSelection [

	| log |
	(log := aSelection selectedItem) ifNil: [ ^ self ].
		
	"zoom model: log asInspectorModel"
	self inspect: log inspector: selectedRecordInspector.
	tabLayout ifNotNil: [ tabLayout select: selectedRecordInspector ]
				
	
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> populateItemsFrom: aLogger [

	| rec |
	rec := aLogger entries copy.
	logList updateItemsKeepingSelection: rec
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> printOneLineContents: aSignal [

		^ String streamContents: [ :aStream | aSignal printOneLineContentsOn: aStream ] 
]

{ #category : 'private' }
StObjectTranscriptPresenter >> recordsInspector [

	^ recordsInspector 
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> refresh [ 
	
	self populateItemsFrom: logger
	
	

]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> removeFromLogger [
	
	logger ifNil: [ ^ self ].
	logger removeAsClient: self
]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> selectLastItem [ 

	^ logList selectIndex: logList listSize 
]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> selectedItem [

	^  logList selectedItem
]

{ #category : 'private' }
StObjectTranscriptPresenter >> selectedRecordInspector [

	^ selectedRecordInspector 
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> setInspectSingleEntry [

	inspectSelectedItem := true
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> showInspector: aBoolean [

	showInspector := aBoolean.
	self layout: self defaultLayout.
	
	aBoolean ifTrue: [ tabLayout select: recordsInspector ]
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> startLogger [

	logger start
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> stopLogger [

	logger stop
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> switchLogger [

	self isLoggerRunning 
		ifTrue: [ self stopLogger ]
		ifFalse: [ self startLogger ]
]

{ #category : 'private' }
StObjectTranscriptPresenter >> tabLayout [ 
	
	^ tabLayout 
]

{ #category : 'private - actions' }
StObjectTranscriptPresenter >> tabSelected: aPresenter [

	aPresenter = recordsInspector ifTrue: [
		self inspect: logger entries inspector: aPresenter.
		logList selectItem: nil ].
	aPresenter = selectedRecordInspector ifTrue: [
		self inspect: self selectedItem inspector: aPresenter ]
]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> windowTitle [ 

	^ 'Object Transcript'
]

{ #category : 'layout' }
StObjectTranscriptPresenter >> withInspectorLayout [
	
	^ SpPanedLayout newTopToBottom 
			add: logList;
			add: (tabLayout := SpTabLayout new
				add: recordsInspector label: 'All logs';
				add: selectedRecordInspector label: 'Selected Log';
				whenTabSelectedDo: [ :ann | self tabSelected: ann presenter ];
				yourself);
			yourself
]

{ #category : 'layout' }
StObjectTranscriptPresenter >> withoutInspectorLayout [
	

	^ SpBoxLayout
		newTopToBottom 
			add: logList ;
		yourself
]
