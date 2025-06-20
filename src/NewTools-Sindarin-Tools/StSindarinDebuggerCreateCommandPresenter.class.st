Class {
	#name : 'StSindarinDebuggerCreateCommandPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'descriptionInput',
		'cancelButton',
		'createButton',
		'package',
		'iconList',
		'iconNameSelected',
		'commandName',
		'code'
	],
	#category : 'NewTools-Sindarin-Tools-Presenters',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
StSindarinDebuggerCreateCommandPresenter >> code: aCode [
	code := aCode 
]

{ #category : 'accessing' }
StSindarinDebuggerCreateCommandPresenter >> commandName: aName [
	commandName := aName asCamelCase 
]

{ #category : 'initialization' }
StSindarinDebuggerCreateCommandPresenter >> connectPresenters [ 
	iconList transmitTo: self
]

{ #category : 'actions' }
StSindarinDebuggerCreateCommandPresenter >> createCommand [
	| name className description class |
	name := (commandName ifNil: ['Default']) asCamelCase.
	className := 'Sindarin{1}Command' format: {name}.
	description := descriptionInput text ifNil: [''].
	
	class := SindarinCommand << className 
		package: package;
		build;
		install.

	class compile: ('execute
	|sindarin|
	sindarin := self context sindarinDebugger.
	self context debuggerActionModel preventUpdatesDuring: [
		{1}
	]' format: {'"TODO"'}) classified: 'executing'.
	
	class class compile: ('defaultIconName
	^#{1}' format: {iconNameSelected}) classified: 'initialization'.
	
	class class compile: ('defaultDescription
	^ ''{1}''' format: {description}) classified: 'initialization'.
	
	class class compile: ('defaultName
	^ ''{1}''' format: {name}) classified: 'initialization'.
	
]

{ #category : 'layout' }
StSindarinDebuggerCreateCommandPresenter >> defaultLayout [ 
	|buttonRow|
	
	buttonRow := SpBoxLayout newLeftToRight
		spacing: 6;
		add: createButton;
		add: cancelButton;
		yourself.

	^ SpBoxLayout newTopToBottom 
		spacing: 5;
		add: descriptionInput expand: false;
		add: iconList;
		add: buttonRow expand: false;
		yourself.
]

{ #category : 'initialization' }
StSindarinDebuggerCreateCommandPresenter >> initializeIconList [
	|icons|
	icons := ThemeIcons loadDefault.
	iconList 
		items: icons allIconNames ;
		display: [ :elm | ThemeIcons iconNamed: elm ]
]

{ #category : 'initialization' }
StSindarinDebuggerCreateCommandPresenter >> initializePresenters [ 
	
	descriptionInput := self newTextInput.  
	descriptionInput placeholder: 'Command description'.
	
	iconList := self newList.
	self initializeIconList.
	
	createButton := self newButton.
	createButton label: 'Create'.
	
	cancelButton := self newButton.
	cancelButton label: 'Cancel'.
	
]

{ #category : 'accessing' }
StSindarinDebuggerCreateCommandPresenter >> package: aPackageName [
	package := aPackageName
]

{ #category : 'transmission' }
StSindarinDebuggerCreateCommandPresenter >> setModel: aIconName [
	iconNameSelected := aIconName.
]

{ #category : 'enumerating' }
StSindarinDebuggerCreateCommandPresenter >> whenCancelButtonDo: aBlock [
	cancelButton action: aBlock .
]

{ #category : 'enumerating' }
StSindarinDebuggerCreateCommandPresenter >> whenCreateButtonDo: aBlock [
	createButton action: aBlock .
]
