Class {
	#name : 'CavWindowPlaceHolder',
	#superclass : 'CavAbstractWindowPlaceHolder',
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'operations' }
CavWindowPlaceHolder >> placePresenter: aPresenter [

	self strategy placeWindow: aPresenter
]
