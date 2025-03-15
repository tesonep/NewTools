Class {
	#name : 'CavWindowStrategyTest',
	#superclass : 'TestCase',
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

{ #category : 'tests' }
CavWindowStrategyTest >> testNullStrategyDoesNotChangeExtentAndPosition [


	| presenterClass presenter |
	presenterClass := SpPresenter newAnonymousSubclass.
	presenterClass compile: 'defaultLayout ^ SpGridLayout new'.
	presenterClass compile: 'initializePresenters self layout: SpBoxLayout newLeftToRight'.
	presenterClass class compile: 'defaultPreferredExtent ^ 666@42'.
	presenterClass compile: 'position ^ 10@10'.
	presenter := presenterClass new.
	self assert: presenter preferredExtent equals: 666@42.
	self assert: presenter position equals: 10@10.
	
	CavNullStrategy new placePresenter: presenter. 
	self assert: presenter preferredExtent equals: 666@42.
	self assert: presenter position equals: 10@10.
	

	
	
	
	
]
