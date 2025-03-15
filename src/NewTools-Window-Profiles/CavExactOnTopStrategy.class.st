Class {
	#name : 'CavExactOnTopStrategy',
	#superclass : 'CavWindowStrategy',
	#category : 'NewTools-Window-Profiles-Model',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Model'
}

{ #category : 'accessing' }
CavExactOnTopStrategy class >> title [

	^ 'Exact on Top Strategy'
]

{ #category : 'positioning' }
CavExactOnTopStrategy >> placePresenter: aPresenter [
	
	aPresenter extent: placeHolder extent.
	aPresenter position: placeHolder position
]
