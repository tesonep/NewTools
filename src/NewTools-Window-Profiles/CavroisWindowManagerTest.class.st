Class {
	#name : 'CavroisWindowManagerTest',
	#superclass : 'TestCase',
	#instVars : [
		'manager',
		'virtualFS'
	],
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

{ #category : 'running' }
CavroisWindowManagerTest >> setUp [

	super setUp.
	CavroisWindowManager reset.
	virtualFS := FileSystem memory root.
	manager := CavroisWindowManager current
]

{ #category : 'running' }
CavroisWindowManagerTest >> tearDown [

	super tearDown.
	CavroisWindowManager reset
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testAddProfileFromWindows [

	| profile |
	profile := manager addProfileFromWindows: 'Profile'.

	self assert: (manager profiles includesKey: 'Profile').
	self assert: manager currentProfile equals: profile
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testConfigurationFromSpSystemWindow [

	| configuration ice window |
	ice := IceTipRepositoriesBrowser new.
	ice
		extent: ice preferredExtent;
		position: 100 @ 100.
	window := ice open.
	configuration := manager placeHolderFromWindow: window window.

	self assert: configuration extent equals: ice preferredExtent.
	self assert: configuration position equals: 100 @ 100.
	window delete
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testConfigurationFromWindow [

	| configuration play |
	[
		play := StPlaygroundPresenter new open.
		configuration := manager placeHolderFromWindow: play window.
		self assert: configuration extent equals: 600.0 @ 400.0 ] ensure: [
		play delete ]
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testCurrentProfile [

	self assert: manager currentProfile isNil.

	manager addProfileFromWindows: 'Profile'.
	self assert: manager currentProfile name equals: 'Profile'
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testDeleteProfile [

	manager addProfileFromWindows: 'ProfileToKeep'.
	manager addProfileFromWindows: 'ProfileToDelete'.

	manager class removeSelectedProfile: 'ProfileToDelete'.

	self deny: (manager profiles includesKey: 'ProfileToDelete').
	self assert: (manager profiles includesKey: 'ProfileToKeep')
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testRemovingCurrentProfileUpdateCurrentProfile [

	manager addProfileFromWindows: 'Profile1'.
	manager addProfileFromWindows: 'Profile2'.
	"adding Current so the method called gets tricked"
	manager addProfileFromWindows: 'Profile3(Current)'.

	CavroisWindowManager removeSelectedProfile: 'Profile3(Current)'.
	self assert: manager currentProfile name equals: 'Profile1'
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testRemovingLastProfileUpdateCurrentProfile [

	manager addProfileFromWindows: 'Profile1'.
	manager class removeSelectedProfile:
		manager profiles keys first.

	self assert: manager profiles isEmpty.
	self assert: manager currentProfile isNil
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testSaveProfile [

	| profile fileRef |
	profile := manager addProfileFromWindows: 'Test'.
	fileRef := virtualFS / 'Profile:Test.ston'.

	manager class saveProfile: virtualFS.

	self assert: fileRef exists.
	fileRef ensureDelete
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testSwitchToProfile [

	manager addProfileFromWindows: 'Profile1'.
	"adding Current so the method called gets tricked"
	manager addProfileFromWindows: 'Profile2(Current)'.

	manager class switchToProfile: 'Profile1'.

	self assert: (manager profiles includesKey: 'Profile1(Current)').
	self assert: (manager profiles includesKey: 'Profile2')
]
