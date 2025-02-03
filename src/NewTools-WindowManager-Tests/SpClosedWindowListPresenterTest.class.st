Class {
	#name : 'SpClosedWindowListPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'testWindow'
	],
	#category : 'NewTools-WindowManager-Tests',
	#package : 'NewTools-WindowManager-Tests'
}

{ #category : 'running' }
SpClosedWindowListPresenterTest >> setUp [

	super setUp.

	presenter := SpClosedWindowListPresenter uniqueInstance.
	testWindow := SystemWindow new
		              setLabel: 'Test Window';
		              extent: 300 @ 200;
		              yourself.
	SpClosedWindowListPresenter uniqueInstance items removeAll
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testAddClosedWindowShouldAddToList [

	self assert: presenter items isEmpty.

	presenter addClosedWindow: testWindow.

	self assert: presenter items size equals: 1.
	self assert: presenter items first equals: testWindow
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testAddClosedWindowShouldRemoveOldestWhenExceeding5Windows [

	| windows |
	windows := (1 to: 6) collect: [ :i | SystemWindow new ].

	windows do: [ :each | presenter addClosedWindow: each ].

	self assert: presenter items size equals: 5.
	self assert:
		(presenter items includes: windows first) not.
	self assert: (presenter items includes: windows last).

	windows do: [ :each | each delete ]
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testInitialSelectionShouldBeFirst [

	presenter addClosedWindow: testWindow.

	self assert: presenter selectedItem equals: testWindow
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testRemoveButtonShouldPermanentlyCloseWindow [

	presenter addClosedWindow: testWindow.
	self deny: testWindow isNil.

	presenter removeButton click.
	self assert: presenter items isEmpty
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testSubscriptionToWindowClosedAnnouncements [

	| announcement |
	announcement := WindowClosed new
		                window: testWindow;
		                yourself.

	self currentWorld announcer announce: announcement.

	self assert: presenter items size equals: 1.
	self assert: presenter items first equals: testWindow
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testUnhideButtonShouldRestoreWindow [

	| originalPosition |
	originalPosition := testWindow position.
	"Hiding testWindow to simulate"
	testWindow visible: false.
	presenter addClosedWindow: testWindow.
	presenter unhideButton click.

	self assert: testWindow visible.
	self assert: testWindow position equals: originalPosition.
	self assert: presenter items isEmpty
]
