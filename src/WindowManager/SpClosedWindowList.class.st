Class {
	#name : 'SpClosedWindowList',
	#superclass : 'SpPresenter',
	#instVars : [
		'title',
		'list',
		'unhideButton',
		'removeButton',
		'unhideItemBlock',
		'label',
		'removeItemBlock'
	],
	#category : 'WindowManager',
	#package : 'WindowManager'
}

{ #category : 'layout' }
SpClosedWindowList class >> defaultLayout [
	^ self layoutWithOrdering
]

{ #category : 'as yet unclassified' }
SpClosedWindowList class >> exampleClosedWindowsList [

	<sampleInstance>
	| presenter |
	presenter := self new
		             items: '';
		             unhideItemBlock: [ 1 ];
		             openWithLayout: self layoutWithOrdering;
		             yourself.

	presenter withWindowDo: [ :w | w title: 'Last Closed Windows' ].

	^ presenter
]

{ #category : 'layout' }
SpClosedWindowList class >> layoutWithOrdering [

	| listLayout |
	listLayout := SpBoxLayout newLeftToRight
		              add: #list;
		              yourself.

	^ SpBoxLayout newTopToBottom
		  add: listLayout;
		  add: (SpBoxLayout newLeftToRight
				   addLast: #unhideButton expand: false;
				   addLast: #removeButton expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'initialization' }
SpClosedWindowList >> connectPresenters [

	super connectPresenters.

	unhideButton action: [
		| newItem |
		list items isNotEmpty ifTrue: [
			newItem := unhideItemBlock cull: self selectedItem ] ].
	removeButton action: [
		list items isNotEmpty ifTrue: [
			removeItemBlock cull: self selectedItem ] ]
]

{ #category : 'api' }
SpClosedWindowList >> display: aBlock [

	list display: aBlock
]

{ #category : 'initialization' }
SpClosedWindowList >> initialize [

	super initialize.

	title := 'Title'.

	removeItemBlock := [ :item |
	                   item ifNotNil: [
		                   self items remove: item.
		                   item closeBoxHit.
		                   self refresh ] ].
	unhideItemBlock := [ :item |
	                   item ifNotNil: [ item visible: true ].
	                   self items remove: item.
	                   self refresh ]
]

{ #category : 'initialization' }
SpClosedWindowList >> initializeDialogWindow: aWindow [

	aWindow addDefaultButton: 'Ok' do: [ :presenter | 
		self performOkAction. 
		presenter close ].

	
]

{ #category : 'initialization' }
SpClosedWindowList >> initializePresenters [

	label := self newLabel.
	list := self newList.
	unhideButton := self newButton.
	removeButton := self newButton.
	unhideButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #undo);
		help: 'Unhide an item from the list'.
	removeButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #remove);
		help: 'Remove a item from the list'
]

{ #category : 'initialization' }
SpClosedWindowList >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title;
	initialExtent: 310@185.
]

{ #category : 'accessing' }
SpClosedWindowList >> items [
	^ list model items
]

{ #category : 'private' }
SpClosedWindowList >> items: anItemList [
	list items: anItemList.
]

{ #category : 'accessing' }
SpClosedWindowList >> label: aString [
	label label: aString 
]

{ #category : 'accessing' }
SpClosedWindowList >> list [
	^ list
]

{ #category : 'initialization' }
SpClosedWindowList >> newList [
	"Default list collection is an Array.
	As this presenter aims to add / remove items from the list, we need a growable collection"
	^ super newList
		items: OrderedCollection new;
		yourself
]

{ #category : 'api' }
SpClosedWindowList >> refresh [

	self items: self items.
	self resetSelection
]

{ #category : 'accessing' }
SpClosedWindowList >> removeButton [
	^ removeButton
]

{ #category : 'api' }
SpClosedWindowList >> removeItem: anObject [

	self items remove: anObject.
	"self resetSelection "
]

{ #category : 'api' }
SpClosedWindowList >> removeItemBlock: aBlock [
	removeItemBlock := aBlock.
]

{ #category : 'api' }
SpClosedWindowList >> resetSelection [
	list selection basicSelectIndex: 1.


]

{ #category : 'api' }
SpClosedWindowList >> selectedItem [
	^ list selection selectedItem
]

{ #category : 'accessing' }
SpClosedWindowList >> title [
	^ title
]

{ #category : 'accessing' }
SpClosedWindowList >> title: aTitle [
	title := aTitle 
]

{ #category : 'accessing' }
SpClosedWindowList >> unhideButton [
	^ unhideButton 
]

{ #category : 'api' }
SpClosedWindowList >> unhideItemBlock: aBlock [
	unhideItemBlock := aBlock.
]

{ #category : 'api' }
SpClosedWindowList >> whenSelectionChangedDo: aBlock [

	list whenSelectionChangedDo: aBlock
]
