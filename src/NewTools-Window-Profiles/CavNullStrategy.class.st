"
I am a null strategy that does nothing by default, i just return the original window
"
Class {
	#name : 'CavNullStrategy',
	#superclass : 'CavWindowStrategy',
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'accessing' }
CavNullStrategy class >> title [

	^ 'Null Strategy'
]

{ #category : 'positioning' }
CavNullStrategy >> placeWindow: aWindow [

	aWindow position: placeHolder position.
	aWindow extent: placeHolder extent.
	^ aWindow
]
