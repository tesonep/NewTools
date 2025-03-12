"
I'm a strategy that has a counter used for having a stack of window with the placeholder position at start point.

I should be modified to have a maximum stacking size because i can place my window out of the screen
"
Class {
	#name : 'CavStackingStrategy',
	#superclass : 'CavWindowStrategy',
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'accessing' }
CavStackingStrategy class >> title [

	^ 'Stacking Strategy'
]

{ #category : 'positioning' }
CavStackingStrategy >> placeWindow: aWindow [
	"for now just stupid"

	aWindow extent: placeHolder extent.
	aWindow position:
		placeHolder position + (20 @ 20 * placeHolder count).
	placeHolder increment
]
