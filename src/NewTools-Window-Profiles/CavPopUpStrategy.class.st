"
I'm a strategy that never creates a new window.

I just checks if the window associated with the placeholder is present, and put it on top of all the windows in the world.
"
Class {
	#name : 'CavPopUpStrategy',
	#superclass : 'CavWindowStrategy',
	#category : 'NewTools-Window-Profiles-Model',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Model'
}

{ #category : 'accessing' }
CavPopUpStrategy class >> title [

	^ 'Pop Up on the Top Strategy'
]

{ #category : 'positioning' }
CavPopUpStrategy >> placePresenter: aWindow [

	aWindow position: placeHolder position.

]
