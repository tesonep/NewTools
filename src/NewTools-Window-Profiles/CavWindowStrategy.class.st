Class {
	#name : 'CavWindowStrategy',
	#superclass : 'Object',
	#instVars : [
		'placeHolder'
	],
	#category : 'NewTools-Window-Profiles-Model',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Model'
}

{ #category : 'accessing' }
CavWindowStrategy class >> title [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
CavWindowStrategy >> placeHolder [

	^ placeHolder
]

{ #category : 'accessing' }
CavWindowStrategy >> placeHolder: anObject [

	placeHolder := anObject
]

{ #category : 'positioning' }
CavWindowStrategy >> placePresenter: aPresenter [

	self placeHolder windows add: aPresenter
]
