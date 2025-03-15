Class {
	#name : 'CavWindowStrategyTest',
	#superclass : 'TestCase',
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

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
