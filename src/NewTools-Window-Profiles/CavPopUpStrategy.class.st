"
I'm a strategy that never creates a new window.

I just checks if the window associated with the placeholder is present, and put it on top of all the windows in the world.
"
Class {
	#name : 'CavPopUpStrategy',
	#superclass : 'CavWindowStrategy',
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'accessing' }
CavPopUpStrategy class >> title [

	^ 'Pop Up Strategy'
]

{ #category : 'positioning' }
CavPopUpStrategy >> placeWindow: aWindow [

	aWindow position: placeHolder position.

]
