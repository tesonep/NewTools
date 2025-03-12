"
I'm a strategy that replace the previous window that was in the placeholder associated by a new one !

It only work if the window has the exact same size and position as the placehokder registered
"
Class {
	#name : 'CavReplaceStrategy',
	#superclass : 'CavWindowStrategy',
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'accessing' }
CavReplaceStrategy class >> title [

	^ 'Replace Strategy'
]

{ #category : 'positioning' }
CavReplaceStrategy >> placeWindow: aWindow [
	"for now just stupid"

	aWindow position: placeHolder position.
	aWindow extent: placeHolder extent.
	"do we keep a reference to the window from the placeholder?
	this way we could avoid to scan all the window."

	"this does not work for now"
	(SystemWindow allInstances select: [ :each |
		 each position = placeHolder position ]) do: [ :each | each delete ].
	(SpWindow allInstances select: [ :each |
		 each position = placeHolder position ]) do: [ :each | each delete ]
]
