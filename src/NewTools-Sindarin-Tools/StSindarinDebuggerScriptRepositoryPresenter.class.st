Class {
	#name : 'StSindarinDebuggerScriptRepositoryPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'scriptList',
		'filter',
		'chooseElement',
		'loadButton',
		'cancelButton',
		'scriptRepository',
		'repositoryChooser'
	],
	#category : 'NewTools-Sindarin-Tools-Presenters',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Presenters'
}

{ #category : 'actions' }
StSindarinDebuggerScriptRepositoryPresenter >> applyFilter [
	|filtered|
	
	filtered := scriptRepository scriptsNames select: [ :each |
		each asLowercase includesSubstring: filter text asLowercase ].
	scriptList items: filtered
]

{ #category : 'accessing' }
StSindarinDebuggerScriptRepositoryPresenter >> chooseElement [
	^ chooseElement 
]

{ #category : 'initialization' }
StSindarinDebuggerScriptRepositoryPresenter >> connectPresenters [

	scriptList transmitTo: self
]

{ #category : 'layout' }
StSindarinDebuggerScriptRepositoryPresenter >> defaultLayout [
	|buttonRow|
	
	buttonRow := SpBoxLayout newLeftToRight
		spacing: 6;
		add: #loadButton;
		add: #cancelButton;
		yourself.

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: repositoryChooser expand: false;
		add: #scriptList;
		add: #filter expand: false;
		add: buttonRow expand: false;
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
	filter placeholder: 'Filter ...'.
	filter whenTextChangedDo: [ self applyFilter ].
	
	loadButton := self newButton.
	loadButton label: 'Load'.
	
	cancelButton := self newButton.
	cancelButton label: 'Cancel'.
	
	repositoryChooser := self newDropList.
	repositoryChooser 
		whenSelectedItemChangedDo: [ :each | self loadRepository: each ];
		items: StSindarinDebuggerScriptRepository subclasses;
		display: [ :each | each repositoryName ].
		
	scriptRepository := SindarinDefaultScriptRepository.
	
]

{ #category : 'actions' }
StSindarinDebuggerScriptRepositoryPresenter >> loadRepository: aSindarinRepository [
	scriptRepository := aSindarinRepository.
	self applyFilter.
]

{ #category : 'actions' }
StSindarinDebuggerScriptRepositoryPresenter >> loadScript: aString [
	^ scriptRepository loadScript: aString.
]

{ #category : 'actions' }
StSindarinDebuggerScriptRepositoryPresenter >> saveScript: aStringName code: aStringCode [
	scriptRepository saveScript: aStringName code: aStringCode.
]

{ #category : 'transmission' }
StSindarinDebuggerScriptRepositoryPresenter >> setModel: aListElement [
	chooseElement := aListElement
]

{ #category : 'actions' }
StSindarinDebuggerScriptRepositoryPresenter >> whenCancelButtonDo: aBlock [
	cancelButton action: aBlock .
]

{ #category : 'actions' }
StSindarinDebuggerScriptRepositoryPresenter >> whenLoadButtonDo: aBlock [
	loadButton action: aBlock .
]
