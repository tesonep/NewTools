Class {
	#name : 'SindarinSkipAllToSelectionCommand',
	#superclass : 'SindarinCommand',
	#category : 'NewTools-Sindarin-Commands',
	#package : 'NewTools-Sindarin-Commands'
}

{ #category : 'accesing - defaults' }
SindarinSkipAllToSelectionCommand class >> defaultIconName [
	^ #rightSide
]

{ #category : 'testing' }
SindarinSkipAllToSelectionCommand class >> isAbstract [

	^ self == SindarinSkipAllToSelectionCommand 
]
