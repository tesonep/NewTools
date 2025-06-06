Class {
	#name : 'StSindarinDebuggerScriptRepositoryPresenter',
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
StSindarinDebuggerScriptRepositoryPresenter >> applyFilter [
	|filtered|
	filtered := StSindarinDebuggerScriptRepository scriptsNames select: [ :each |
		each asLowercase includesSubstring: filter text asLowercase ].
	scriptList items: filtered
]

{ #category : 'initialization' }
StSindarinDebuggerScriptRepositoryPresenter >> connectPresenters [

	scriptList transmitTo: self
]

{ #category : 'layout' }
StSindarinDebuggerScriptRepositoryPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 8;
		add: filter expand: false; 
		add: scriptList;
		yourself
]

{ #category : 'initialization' }
StSindarinDebuggerScriptRepositoryPresenter >> initializeDialogWindow: aWindow [
	super initializeDialogWindow: aWindow.
	aWindow title: 'Load a script'.
]

{ #category : 'initialization' }
StSindarinDebuggerScriptRepositoryPresenter >> initializePresenters [

	scriptList := self newList.
	
	filter := self newTextInput.
	filter whenTextChangedDo: [ self applyFilter ].
	
	self applyFilter.
	
]

{ #category : 'showing' }
StSindarinDebuggerScriptRepositoryPresenter >> openModal [
	super openModal cancelled ifTrue: [ ^ nil ].
	^ chooseElement
]

{ #category : 'transmission' }
StSindarinDebuggerScriptRepositoryPresenter >> setModel: aListElement [

	chooseElement := aListElement
]
