Class {
	#name : 'StKMCategoryAll',
	#superclass : 'Object',
	#instVars : [
		'categoryName',
		'shortcuts'
	],
	#category : 'NewTools-ShortcutsBrowser',
	#package : 'NewTools-ShortcutsBrowser'
}

{ #category : 'copying' }
StKMCategoryAll >> , aKMCategory [

	self shortcuts addAll: aKMCategory allEntries keymaps
]

{ #category : 'comparing' }
StKMCategoryAll >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ categoryName = anObject categoryName and: [
		  shortcuts = anObject shortcuts ]
]

{ #category : 'adding' }
StKMCategoryAll >> addAll: aCollection [ 
	"Add all shortcuts in aCollection to the receiver"
	
	self shortcuts addAll: aCollection
]

{ #category : 'accessing' }
StKMCategoryAll >> categoryName [

	^ categoryName
]

{ #category : 'accessing' }
StKMCategoryAll >> categoryName: anObject [

	categoryName := anObject
]

{ #category : 'comparing' }
StKMCategoryAll >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ categoryName hash bitXor: shortcuts hash
]

{ #category : 'accessing' }
StKMCategoryAll >> icon [

	^ self iconNamed: self systemIconName
]

{ #category : 'accessing' }
StKMCategoryAll >> model [
	"Required by <SpDropListPresenter> ?"

	^ self
]

{ #category : 'accessing' }
StKMCategoryAll >> name [

	^  self categoryName
]

{ #category : 'printing' }
StKMCategoryAll >> printOn: aStream [
	"Generate a string representation of the receiver based on its instance variables."

	super printOn: aStream.
	aStream
		nextPutAll: ' [';
		print: categoryName;
		nextPutAll: ']'
]

{ #category : 'accessing' }
StKMCategoryAll >> shortcuts [

	^ shortcuts
		ifNil: [ shortcuts := OrderedCollection new ]
]

{ #category : 'accessing' }
StKMCategoryAll >> shortcuts: anObject [

	shortcuts := anObject
]
