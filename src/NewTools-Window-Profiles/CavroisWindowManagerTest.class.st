Class {
	#name : 'CavroisWindowManagerTest',
	#superclass : 'TestCase',
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'initialization' }
CavroisWindowManagerTest >> setUp [

	CavroisWindowManager reset
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testConfigurationFromSpSystemWindow [

	| prof configuration ice window |
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
	prof := CavroisWindowManager new.
	transcript := Transcript open
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
	[ prof := CavroisWindowManager new.
	play := StPlaygroundPresenter new open.
	configuration := prof placeHolderFromWindow: play window.
	self assert: configuration  extent equals: (600.0@400.0).
	] ensure: [ play delete ]
	
]

{ #category : 'tests' }
CavroisWindowManagerTest >> testPresenterHasCorrectAPI [

	| pres win |
	[ pres := SpPresenter new.
	pres layout: SpBoxLayout new. 
	pres position:  100@100.
	pres extent: 200@333.
	
	self assert: pres initialPosition equals: 100@100.
	self assert: pres extent equals: 200@333.
	"this test is key because else we cannot pass to the window 
	the size and position we want. "
	
	win := pres open.
	self assert: win initialExtent equals: 200@333.
	self assert: win position equals: 100@100.
	] ensure: [ win close ]
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
