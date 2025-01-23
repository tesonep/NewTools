Class {
	#name : 'SpClosedWindowListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'list',
		'unhideButton',
		'removeButton',
		'unhideItemBlock',
		'label',
		'removeItemBlock',
		'title',
		'lastClosedWindows'
	],
	#classInstVars : [
		'lastClosedWindows'
	],
	#category : 'NewTools-WindowManager',
	#package : 'NewTools-WindowManager'
}

{ #category : 'layout' }
SpClosedWindowListPresenter class >> defaultLayout [
	^ self layoutWithOrdering
]

{ #category : 'accessing' }
SpClosedWindowListPresenter class >> defaultPreferredExtent [

	^ 310 @ 185
]

{ #category : 'example' }
SpClosedWindowListPresenter class >> exampleClosedWindowsList [

	<sampleInstance>
	| presenter |
	presenter := self new
		             items: SpWindow allInstances ;
		             unhideItemBlock: [ 1 ];
		             openWithLayout: self layoutWithOrdering;
		             yourself.


	^ presenter
]

{ #category : 'accessing' }
SpClosedWindowListPresenter class >> lastClosedWindows [

	^ lastClosedWindows ifNil: [  lastClosedWindows := OrderedCollection new ]
]

{ #category : 'layout' }
SpClosedWindowListPresenter class >> layoutWithOrdering [

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

{ #category : 'instance creation' }
SpClosedWindowListPresenter class >> open [

	<script>
	self new
		items: lastClosedWindows;
		openWithLayout: self layoutWithOrdering.
	self new resetSelection.
	^ self
]

{ #category : 'adding' }
SpClosedWindowListPresenter >> addClosedWindow: aModel [

	self lastClosedWindows size >= 5 ifTrue: [
		self lastClosedWindows removeLast close ].
	self lastClosedWindows addFirst: aModel.

]

{ #category : 'initialization' }
SpClosedWindowListPresenter >> connectPresenters [

	super connectPresenters.

	unhideButton action: [
		| newItem |
		list items isNotEmpty ifTrue: [
			newItem := unhideItemBlock cull: self selectedItem ] ].
	removeButton action: [
		list items isNotEmpty ifTrue: [
			removeItemBlock cull: self selectedItem ] ]
]

{ #category : 'initialization' }
SpClosedWindowListPresenter >> initialize [

	super initialize.
	title:= 'Last Closed Windows'.
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
SpClosedWindowListPresenter >> initializePresenters [

	label := self newLabel.
	list := self newList
		        items: OrderedCollection new;
		        display: [ :s | s displayString ].
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

{ #category : 'accessing' }
SpClosedWindowListPresenter >> items [

	^ list model items
]

{ #category : 'private' }
SpClosedWindowListPresenter >> items: anItemList [
	(list items: anItemList) whenActivatedDo: [ :selection | unhideItemBlock cull: selection selectedItem ]
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> label: aString [
	label label: aString 
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> lastClosedWindows [

	^ self class lastClosedWindows
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> list [

	^ list 
]

{ #category : 'api' }
SpClosedWindowListPresenter >> refresh [

	self items: self items.
	self resetSelection
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> removeButton [
	^ removeButton
]

{ #category : 'api' }
SpClosedWindowListPresenter >> removeItem: anObject [

	self items remove: anObject.
	"self resetSelection "
]

{ #category : 'api' }
SpClosedWindowListPresenter >> removeItemBlock: aBlock [
	removeItemBlock := aBlock.
]

{ #category : 'api' }
SpClosedWindowListPresenter >> resetSelection [
	list selection basicSelectIndex: 1.


]

{ #category : 'api' }
SpClosedWindowListPresenter >> selectedItem [
	^ list selection selectedItem
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> title [
	^ title
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> title: aTitle [

	title := aTitle
]

{ #category : 'accessing' }
SpClosedWindowListPresenter >> unhideButton [
	^ unhideButton 
]

{ #category : 'api' }
SpClosedWindowListPresenter >> unhideItemBlock: aBlock [
	unhideItemBlock := aBlock.
]
