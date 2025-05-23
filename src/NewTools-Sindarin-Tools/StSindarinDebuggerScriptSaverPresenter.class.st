Class {
	#name : 'StSindarinDebuggerScriptSaverPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'scriptList',
		'chooseElement'
	],
	#category : 'NewTools-Sindarin-Tools-Presenters',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
StSindarinDebuggerScriptSaverPresenter >> connectPresenters [

	scriptList transmitTo: self
]

{ #category : 'layout' }
StSindarinDebuggerScriptSaverPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: scriptList;
		  yourself
]

{ #category : 'initialization' }
StSindarinDebuggerScriptSaverPresenter >> initializeDialogWindow: aWindows [

	aWindows
		addButton: 'Cancel' do: [ :presenter |
				presenter triggerCancelAction.
				presenter close ];
		addDefaultButton: 'Load Script' do: [ :presenter |
				chooseElement ifNotNil: [
							presenter beOk.
							presenter close ] ]
]

{ #category : 'initialization' }
StSindarinDebuggerScriptSaverPresenter >> initializePresenters [

	scriptList := self newList.

	scriptList items: StSindarinDebuggerScriptSaver scriptsNames.
	
]

{ #category : 'showing' }
StSindarinDebuggerScriptSaverPresenter >> openModal [
	self reloadListSrcipt.
	super openModal cancelled ifTrue: [ ^ nil ].
	^ chooseElement
]

{ #category : 'as yet unclassified' }
StSindarinDebuggerScriptSaverPresenter >> reloadListSrcipt [

	scriptList items: StSindarinDebuggerScriptSaver scriptsNames.
]

{ #category : 'transmission' }
StSindarinDebuggerScriptSaverPresenter >> setModel: aListElement [

	chooseElement := aListElement
]
