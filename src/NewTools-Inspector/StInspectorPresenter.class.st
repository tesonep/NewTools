"
I am an inspector of objects. 
I offer multiple views using a miller list as a navigation. 
One particular feature is that you can use the evaluator tab to enter code, and evaluating it results in opening another pane to the right.

The object finder asks dynamically the object for the actual presentations that are displayed in each pane.

Example:
self openOn: Smalltalk.

Register it as a replacement for inspector:
self registerToolsOn: Smalltalk tools.
"
Class {
	#name : 'StInspectorPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'millerList',
		'model',
		'lastPageSelectedTabName',
		'withHeaderBar'
	],
	#classVars : [
		'IndexableDisplayLimit',
		'InspectorDiveOnSingleClick'
	],
	#category : 'NewTools-Inspector-View',
	#package : 'NewTools-Inspector',
	#tag : 'View'
}

{ #category : 'settings' }
StInspectorPresenter class >> defaultInspectorDiveOnSingleClick [

	^ true
]

{ #category : 'layout' }
StInspectorPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: #millerList;
		yourself
]

{ #category : 'accessing' }
StInspectorPresenter class >> defaultSpacing [

	^ 3
]

{ #category : 'instance creation' }
StInspectorPresenter class >> explore: anObject [
 
	self openOn: anObject.
	^ anObject
]

{ #category : 'settings' }
StInspectorPresenter class >> indexableDisplayLimit [

	^ IndexableDisplayLimit ifNil: [ 5000 ]
]

{ #category : 'settings' }
StInspectorPresenter class >> indexableDisplayLimit: aNumber [

	IndexableDisplayLimit := aNumber
]

{ #category : 'instance creation' }
StInspectorPresenter class >> inspect: anObject [

	^ self openOn: anObject
]

{ #category : 'instance creation' }
StInspectorPresenter class >> inspect: anObject label: aString [

	(self openOn: anObject) title: aString.
	^ anObject

]

{ #category : 'settings' }
StInspectorPresenter class >> inspectorDiveOnSingleClick [

	^ InspectorDiveOnSingleClick ifNil: [
		InspectorDiveOnSingleClick := self defaultInspectorDiveOnSingleClick ]
]

{ #category : 'settings' }
StInspectorPresenter class >> inspectorDiveOnSingleClick: aBoolean [

	InspectorDiveOnSingleClick := aBoolean
]

{ #category : 'instance creation' }
StInspectorPresenter class >> onObject: anObject [

	^ self on: (StInspectorModel on: anObject)
]

{ #category : 'instance creation' }
StInspectorPresenter class >> openOn: anObject [

	^ (self onObject: anObject) open
]

{ #category : 'tools registry' }
StInspectorPresenter class >> registerToolsOn: registry [
	"self registerToolsOn: self currentApplication tools
	But do not use self currentApplication this is a global." 
	
	registry register: self as: #inspector.
	registry register: self as: #basicInspector
]

{ #category : 'settings' }
StInspectorPresenter class >> settingsOn: aBuilder [
	<systemsettings>

	(aBuilder group: #inspector)
		parent: #tools;
		label: 'Inspector';
		description: 'Inspector'.
		
	(aBuilder setting: #inspectorDiveOnSingleClick)
		parent: #inspector;
		default: self inspectorDiveOnSingleClick;
		target: self;
		description: 'Whether inspector will dive with single or double click';
		label: 'Dive on single click'
]

{ #category : 'transmission' }
StInspectorPresenter >> defaultInputPort [

	^ self inputModelPort
]

{ #category : 'api - focus' }
StInspectorPresenter >> defaultKeyboardFocus [

	^ millerList presenters 
		ifNotEmpty: [ :list | list first ] 
		ifEmpty: [ self ]
]

{ #category : 'accessing' }
StInspectorPresenter >> firstPage [

	^ millerList pages first
]

{ #category : 'initialization' }
StInspectorPresenter >> initializePresenters [

	millerList := self instantiate: SpMillerPaginatorPresenter.
	millerList millerListPresenter
		spacing: self spacing;
		presenterBlock: [ :aModel | self newInspectorFor: aModel ];
		setRootModel: self model;
		whenColumnsWillChangeDo: [ self keepLastPageSelectedTabName ]
]

{ #category : 'initialization' }
StInspectorPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter 
		whenOpenedDo: [ self takeKeyboardFocus ];
		whenFocusReceivedDo: [ self startProcessing ];
		whenFocusLostDo: [ self stopProcessing ];
		whenClosedDo: [ self stopProcessing ]
]

{ #category : 'transmission' }
StInspectorPresenter >> inputModelPort [

	^ SpModelPort newPresenter: self
]

{ #category : 'private' }
StInspectorPresenter >> keepLastPageSelectedTabName [
	
	lastPageSelectedTabName := millerList pages 
		ifNotEmpty: [ :pages | pages last selectedPageName ]
		ifEmpty: [ nil ]
]

{ #category : 'accessing' }
StInspectorPresenter >> millerList [

	^ millerList
]

{ #category : 'accessing' }
StInspectorPresenter >> model [

	^ model
]

{ #category : 'accessing - model' }
StInspectorPresenter >> model: anInspectorModel [

	model := anInspectorModel.
	self updateTitle.
	self updateList
]

{ #category : 'private - factory' }
StInspectorPresenter >> newInspectorFor: aModel [
	| newInspector |

	newInspector := self
		instantiate: aModel defaultObjectInspectorClass
		on: aModel asInspectorModel.
	self class inspectorDiveOnSingleClick 
		ifTrue: [ newInspector activateOnSingleClick ].
	
	millerList pages ifNotEmpty: [ :pages | 
		newInspector 
			"prepare to close"
			whenClosedDo: [ millerList removeAllFrom: newInspector  ];
			"select last shown page (or default)"
			trySelectAnyPageWithName: { 
				lastPageSelectedTabName. 
				pages last selectedPageName } ].
		
	^ newInspector
]

{ #category : 'private' }
StInspectorPresenter >> setModel: aModel [

	self model: aModel
]

{ #category : 'accessing - model' }
StInspectorPresenter >> setModelBeforeInitialization: anInspectorModel [

	model := anInspectorModel
]

{ #category : 'accessing' }
StInspectorPresenter >> spacing [
	
	^ self class defaultSpacing
]

{ #category : 'private - stepping' }
StInspectorPresenter >> startProcessing [

	StInspectorRefreshService uniqueInstance register: self
]

{ #category : 'private - stepping' }
StInspectorPresenter >> step [ 

	millerList pages
		do: [ :each | each step ]
]

{ #category : 'private - stepping' }
StInspectorPresenter >> stopProcessing [

	StInspectorRefreshService uniqueInstance unregister: self
]

{ #category : 'private - updating' }
StInspectorPresenter >> updateList [

	millerList millerListPresenter
		resetTo: 0;
		setRootModel: self model
]

{ #category : 'private - updating' }
StInspectorPresenter >> updateTitle [
		
	self isRoot ifFalse: [ ^ self ].
	self withWindowDo: [ :window | 
		window title: self windowTitle ].
]

{ #category : 'initialization' }
StInspectorPresenter >> windowIcon [
	
	^ self iconNamed: #smallInspectIt
]

{ #category : 'initialization' }
StInspectorPresenter >> windowTitle [
	"in the past the definition was 
	
	^ self model windowTitle but I could not make it during the massive cleaning of Spec.
	Sorry about it - SD"
	^ 'Inspector'
]

{ #category : 'accessing' }
StInspectorPresenter >> withHeaderBar [

	 ^ withHeaderBar ifNil: [ withHeaderBar := true ]
]

{ #category : 'accessing' }
StInspectorPresenter >> withHeaderBar: bool [

	withHeaderBar := bool
]
