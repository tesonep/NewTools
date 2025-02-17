"
I'm a circular logger that works with `StObjectTranscriptPresenter` instances.
II get a direct reference to my UI so that I can ask them to refresh them.
I do not use announcements for this by design!

You can show/hide the inspector and the inspector can either display the currently selected log entry or the complete list so that we can perform collection operations for complex filters. 

"
Class {
	#name : 'StObjectTranscriptPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'logList',
		'zoom',
		'logger',
		'inspectSelectedItem',
		'showInspector'
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
	"This does oot work and is a perfect case to make the remembering only be used when 
	it is coming from a resized
	
	The behavior should be 
		open -> we use these 
		reopen -> we use these
		onResize -> we store the resize and continue to use them.
	
	"
	^ self showInspector
		ifTrue: [ 450 @ 650 ]
		ifFalse: [ 250 @ 450 ]
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

{ #category : 'initialization' }
StObjectTranscriptPresenter >> connectPresenters [
	
	logList whenSelectionChangedDo: [ :selection |
		selection selectedItem
			ifNotNil: [ :log | 
				"zoom model: log asInspectorModel"
				inspectSelectedItem 
						ifTrue: [ self inspect: log ]
						ifFalse: [ self inspect: logger recordings ]
				]]
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> defaultLayout [
	
	^ showInspector 
		ifTrue: [ self withInspectorLayout ]
		ifFalse: [ self withoutInspectorLayout ]
]

{ #category : 'customization' }
StObjectTranscriptPresenter >> defaultShowInspector [

	^ ShowInspector ifNil: [ ShowInspector := true ]
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initialize [

	super initialize. 
	inspectSelectedItem := true.
	showInspector := self defaultShowInspector
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initializePresenters [

	logList := self instantiate: SpFilteringListPresenter.
	zoom := StInspectorPresenter newApplication: self application. 

	logList 
		addActionWith: [ :item | item
			name: 'Toggle inspector entities';
			iconName: #smallHelp;
			action: [ inspectSelectedItem := inspectSelectedItem not ] ];
		addActionWith: [ :item | item
			name: 'Hide/Show inspector';
			iconName: #inspect;
			action: [ self showInspector: showInspector not ] ].
	
	
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> initializeWindow: aWindowPresenter [


	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ logger removeAsClient: self ]
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> inspect: anObject [
	
	zoom model: anObject asInspectorModel
		
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> logger: aLogger [
	
	aLogger ifNil: [ ^ self ].
	logger := aLogger.
	logger addAsClient: self. 
	logList items: aLogger recordings.
	
]

{ #category : 'customization' }
StObjectTranscriptPresenter >> preferredExtent [
	"Answer the desired extent for the receiver when it is first opened on the screen.  "

	^ showInspector
		ifTrue: [ 450 @ 650 ]
		ifFalse: [ 250 @ 450 ]
]

{ #category : 'actions' }
StObjectTranscriptPresenter >> refresh [ 
	
	logList items: logger recordings.
	logList scrollToIndex: logList listSize.

]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> selectedItem [

	^  logList selectedItem
]

{ #category : 'initialization' }
StObjectTranscriptPresenter >> showInspector: aBoolean [

	showInspector := aBoolean.
	self layout: self defaultLayout.
]

{ #category : 'accessing' }
StObjectTranscriptPresenter >> windowTitle [ 

	^ 'Object Transcript'
]

{ #category : 'customization' }
StObjectTranscriptPresenter >> withInspectorLayout [
	

	^ SpBoxLayout
		newTopToBottom 
			add: logList ;
			add: zoom ;
		yourself
]

{ #category : 'customization' }
StObjectTranscriptPresenter >> withoutInspectorLayout [
	

	^ SpBoxLayout
		newTopToBottom 
			add: logList ;
		yourself
]
