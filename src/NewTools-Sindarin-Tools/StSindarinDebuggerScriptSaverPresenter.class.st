Class {
	#name : 'StSindarinDebuggerScriptSaverPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'scriptList',
		'filter',
		'chooseElement'
	],
	#category : 'NewTools-Sindarin-Tools-Presenters',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Presenters'
}

{ #category : 'actions' }
StSindarinDebuggerScriptSaverPresenter >> applyFilter [
	|filtered|
	filtered := StSindarinDebuggerScriptSaver scriptsNames select: [ :each |
		each asLowercase includesSubstring: filter text asLowercase ].
	scriptList items: filtered
]

{ #category : 'initialization' }
StSindarinDebuggerScriptSaverPresenter >> connectPresenters [

	scriptList transmitTo: self
]

{ #category : 'layout' }
StSindarinDebuggerScriptSaverPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 8;
		add: filter expand: false; 
		add: scriptList;
		yourself
]

{ #category : 'initialization' }
StSindarinDebuggerScriptSaverPresenter >> initializeDialogWindow: aWindow [
	super initializeDialogWindow: aWindow.
	aWindow title: 'Load a script'.
]

{ #category : 'initialization' }
StSindarinDebuggerScriptSaverPresenter >> initializePresenters [

	scriptList := self newList.
	
	filter := self newTextInput.
	filter whenTextChangedDo: [ self applyFilter ].
	
	self applyFilter.
	
]

{ #category : 'showing' }
StSindarinDebuggerScriptSaverPresenter >> openModal [
	super openModal cancelled ifTrue: [ ^ nil ].
	^ chooseElement
]

{ #category : 'transmission' }
StSindarinDebuggerScriptSaverPresenter >> setModel: aListElement [

	chooseElement := aListElement
]
