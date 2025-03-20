Class {
	#name : 'CavroisWindowManagerTest',
	#superclass : 'TestCase',
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

{ #category : 'running' }
CavroisWindowManagerTest >> setUp [
	super setUp.

	CavroisWindowManager reset
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testConfigurationFromSpSystemWindow [

	| prof configuration ice window |
	self skip. 
	self flag: #revisitAlexis.
	prof := CavroisWindowManager new.
	ice := IceTipRepositoriesBrowser new.
	ice 
		extent: ice preferredExtent ; 
		position: 100@100.
	window := ice open. 	
	configuration := prof placeHolderFromWindow: window window.
	self assert: configuration extent equals:ice preferredExtent.
	self assert: configuration position equals: 100@100.
	window delete
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testConfigurationFromSystemWindow [

	| prof configuration transcript |
	self skip. 
	self flag: #revisitAlexis.
	prof := CavroisWindowManager new.
	transcript := StTranscriptPresenter open
							extent: (447.0@300.0) ; 
							bounds: ((699.0@460.0) corner: (1146.0@760.0)); 
					 		yourself.
	configuration := prof placeHolderFromWindow: transcript.
	self assert:  configuration  extent  equals:(447.0@300.0).
	self assert:  configuration  position equals: (699.0@460.0).
	transcript delete
	
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testConfigurationFromWindow [

	| prof configuration play |
	self skip.
	self flag: #Alexis.
	[ prof := CavroisWindowManager new.
	play := StPlaygroundPresenter new open.
	configuration := prof placeHolderFromWindow: play window.
	self assert: configuration  extent equals: (600.0@400.0).
	] ensure: [ play delete ]
	
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testRemovingCurrentProfileUpdateCurrentProfile [

	CavroisWindowManager current addProfileFromWindows: 'Profile 1'.
	CavroisWindowManager current addProfileFromWindows: 'Profile 2'.
	"adding Current so the method called gets tricked"
	CavroisWindowManager current addProfileFromWindows:
		'Profile 3 (Current)'.

	CavroisWindowManager removeSelectedProfile: 'Profile 3 (Current)'.
	self
		assert: CavroisWindowManager current currentProfile name
		equals: 'Profile 1'
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testRemovingLastProfileUpdateCurrentProfile [

	CavroisWindowManager current addProfileFromWindows: 'Profile 1'.
	CavroisWindowManager removeSelectedProfile:
		CavroisWindowManager current profiles keys first.

	self assert: CavroisWindowManager current profiles isEmpty.
	self assert: CavroisWindowManager current currentProfile isNil
]
