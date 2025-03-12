Extension { #name : 'SpWindow' }

{ #category : '*NewTools-Window-Profiles' }
SpWindow >> configurePlaceHolder: aPlaceHolder [
	
	aPlaceHolder kind: self model presenter class 
]

{ #category : '*NewTools-Window-Profiles' }
SpWindow >> position: aNewPosition [

	super position: aNewPosition.
	model ifNotNil: [ model position: aNewPosition ]
]
