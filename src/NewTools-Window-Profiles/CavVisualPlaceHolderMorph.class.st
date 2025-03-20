"
I'm morph to represent a placeholder.
"
Class {
	#name : 'CavVisualPlaceHolderMorph',
	#superclass : 'BorderedMorph',
	#instVars : [
		'placeHolder'
	],
	#category : 'NewTools-Window-Profiles-Morphic',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Morphic'
}

{ #category : 'actions' }
CavVisualPlaceHolderMorph >> changeStrategy [

	| presenter description |
	presenter := SpSelectDialog new
		             title: 'Change Strategy';
		             label: 'Select the strategy you want to use';
		             items: CavWindowStrategy subclasses;
		             display: [ :each | each title ];
		             onAccept: [ :dialog |
			             placeHolder strategy:
					             dialog presenter selectedItem new.
			             CavroisWindowManager current removeVisualPlaceholders ].
	description := presenter newText text:
		               presenter list selectedItem comment.
	presenter layout add: description.
	presenter list whenSelectionChangedDo: [
		description text: presenter list selectedItem comment asString ].

	presenter openDialog
]

{ #category : 'initialization' }
CavVisualPlaceHolderMorph >> initialize [

	super initialize.
	self borderWidth: 3.
	self borderColor: UITheme current selectionColor.
	self color: (UITheme current lightSelectionColor alpha: 0.2).
	self eventHandler: MorphicEventHandler new.
	self eventHandler on: #click send: #changeStrategy to: self.
]

{ #category : 'accessing' }
CavVisualPlaceHolderMorph >> placeHolder: aPlaceHolder [

	placeHolder := aPlaceHolder
]
