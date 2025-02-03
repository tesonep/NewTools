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

	presenter := SpClosedWindowListPresenter new.
	testWindow := SystemWindow new
		              setLabel: 'Test Window';
		              extent: 300 @ 200;
		              yourself.
	SpClosedWindowListPresenter lastClosedWindows removeAll
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testAddClosedWindowShouldAddToList [

	self assert: presenter lastClosedWindows isEmpty.

	presenter addClosedWindow: testWindow.

	self assert: presenter lastClosedWindows size equals: 1.
	self assert: presenter lastClosedWindows first equals: testWindow
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testAddClosedWindowShouldRemoveOldestWhenExceeding5Windows [

	| windows |
	windows := (1 to: 6) collect: [ :i | SystemWindow new ].

	windows do: [ :each | presenter addClosedWindow: each ].

	self assert: presenter lastClosedWindows size equals: 5.
	self assert:
		(presenter lastClosedWindows includes: windows first) not.
	self assert: (presenter lastClosedWindows includes: windows last).

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
	self assert: presenter lastClosedWindows isEmpty
]

{ #category : 'tests' }
SpClosedWindowListPresenterTest >> testSubscriptionToWindowClosedAnnouncements [

	| announcement |
	announcement := WindowClosed new
		                window: testWindow;
		                yourself.

	self currentWorld announcer announce: announcement.

	self assert: presenter lastClosedWindows size equals: 1.
	self assert: presenter lastClosedWindows first equals: testWindow
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
	self assert: presenter lastClosedWindows isEmpty
]
