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
		'code',
		'projectName'
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
	name := commandName ifNil: [ 'NoName' ].
	className := 'Sindarin{1}{2}Command' format: {
			             projectName asCamelCase.
			             name asCamelCase }.
	description := descriptionInput text ifNil: [ '' ].

	class := (SindarinCommand << className)
		         package: package;
		         build;
		         install.

	class
		compile: ('execute
	|sindarin|
	sindarin := self context sindarinDebugger.
	self context debuggerActionModel preventUpdatesDuring: [
		{1}
	]' format: { code })
		classified: 'executing'.

	class class
		compile: ('defaultIconName
	^#{1}' format: { iconNameSelected })
		classified: 'initialization'.

	class class
		compile: ('defaultDescription
	^ ''{1}''' format: { description })
		classified: 'initialization'.

	class class
		compile: ('defaultName
	^ ''{1}''' format: { name })
		classified: 'initialization'.

	class comment:
		('This command was generated dynamically on {1} at {2}.
Project: {3}
Name: {4}
Description: {5}' format: {
				 Date today yyyymmdd.
				 Time now print24.
				 projectName.
				 name.
				 description }).

	self createMenu
]

{ #category : 'actions' }
StSindarinDebuggerCreateCommandPresenter >> createMenu [

	StDebugger class
		compile:
			('buildSindarin{2}ExtentionCommandsGroupWith: stDebuggerInstance forRoot: rootCommandGroup
	<extensionCommands>
	| commands toolbarCommandGroup |
	commands := (SindarinCommand subclasses select: [ :sub | sub packageName = ''{3}'']) collect: [ :each | each forSpecContext: stDebuggerInstance ].
	
	toolbarCommandGroup := CmCommandGroup forSpec
		beToolbarPopoverButton;
		name: ''{1}'';
		icon: (stDebuggerInstance application iconNamed: #changeUpdate);
		yourself.
	
	(self debuggerToolbarCommandGroupFor: rootCommandGroup) register: toolbarCommandGroup.
	
	commands do: [ :command | toolbarCommandGroup register: command ].'
				 format: {
						 projectName.
						 projectName asCamelCase.
						 package })
		classified: '*' , package
]

{ #category : 'layout' }
StSindarinDebuggerCreateCommandPresenter >> defaultLayout [

	| buttonRow |
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
		  yourself
]

{ #category : 'actions' }
StSindarinDebuggerCreateCommandPresenter >> deleteCommand [

	| name className commandsLeft |
	name := commandName ifNil: [ 'NoName' ].
	className := 'Sindarin{1}{2}Command' format: {
			             projectName asCamelCase.
			             name asCamelCase }.

	(Smalltalk globals includesKey: className asSymbol) ifTrue: [
		(Smalltalk globals at: className asSymbol) removeFromSystem ].

	commandsLeft := SindarinCommand subclasses select: [ :sub |
		                sub packageName = package ].
	commandsLeft isEmpty ifTrue: [ self deleteMenu ]
]

{ #category : 'actions' }
StSindarinDebuggerCreateCommandPresenter >> deleteMenu [

	| buildGroupMethodName |
	buildGroupMethodName := 'buildSindarin{1}ExtentionCommandsGroupWith:forRoot:'
		                        format: { projectName asCamelCase }.

	(StDebugger class includesSelector: buildGroupMethodName asSymbol)
		ifTrue: [
		StDebugger class removeSelector: buildGroupMethodName asSymbol ]
]

{ #category : 'initialization' }
StSindarinDebuggerCreateCommandPresenter >> initializeIconList [

	| icons |
	icons := ThemeIcons loadDefault.
	iconList
		items: icons allIconNames;
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
	cancelButton label: 'Cancel'
]

{ #category : 'accessing' }
StSindarinDebuggerCreateCommandPresenter >> package: aPackageName [

	package := aPackageName
]

{ #category : 'accessing' }
StSindarinDebuggerCreateCommandPresenter >> projectName: aName [

	projectName := aName
]

{ #category : 'transmission' }
StSindarinDebuggerCreateCommandPresenter >> setModel: aIconName [

	iconNameSelected := aIconName
]

{ #category : 'enumerating' }
StSindarinDebuggerCreateCommandPresenter >> whenCancelButtonDo: aBlock [

	cancelButton action: aBlock
]

{ #category : 'enumerating' }
StSindarinDebuggerCreateCommandPresenter >> whenCreateButtonDo: aBlock [

	createButton action: aBlock
]
