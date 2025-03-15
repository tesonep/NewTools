Class {
	#name : 'CavWindowStrategyTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenterClass',
		'presenter',
		'placeHolder'
	],
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

{ #category : 'tests' }
CavWindowStrategyTest >> setUp [


	presenter := SpPresenterForTestingCavrois new.
	presenter position: 10@10.
	self assert: presenter preferredExtent equals: 666@42.
	self assert: presenter position equals: 10@10.
	placeHolder := (CavWindowPlaceHolder new position: 101@101; extent: 100@200).
	
	
	
	
]

{ #category : 'tests' }
CavWindowStrategyTest >> testNullStrategyDoesNotChangeExtentAndPosition [


	| presenterClass presenter strategy |
	presenterClass := SpPresenter newAnonymousSubclass.
	presenterClass compile: 'defaultLayout ^ SpGridLayout new'.
	presenterClass compile: 'initializePresenters self layout: SpBoxLayout newLeftToRight'.
	presenterClass class compile: 'defaultPreferredExtent ^ 666@42'.
	presenterClass compile: 'position ^ 10@10'.
	presenter := presenterClass new.
	self assert: presenter preferredExtent equals: 666@42.
	self assert: presenter position equals: 10@10.
	
	strategy := CavNullStrategy new.
	strategy placeHolder: (CavWindowPlaceHolder new position: 101@101; extent: 100@200).
	strategy placePresenter: presenter.
	 
	self assert: presenter preferredExtent equals: 666@42.
	self assert: presenter position equals: 10@10.
	

	
	
	
	
]
