Class {
	#name : 'SpPresenterForTestingCavrois',
	#superclass : 'SpPresenter',
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

{ #category : 'accessing' }
SpPresenterForTestingCavrois class >> defaultPreferredExtent [ 
	
	^ 666@42
]

{ #category : 'accessing' }
SpPresenterForTestingCavrois class >> resetExtent [

	customExtent := nil
]

{ #category : 'initialization' }
SpPresenterForTestingCavrois >> initializePresenters [ 
	self layout: SpBoxLayout newLeftToRight
]

{ #category : 'initialization' }
SpPresenterForTestingCavrois >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter resizable: true.
	
]
