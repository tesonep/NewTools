"
I am a StDebugger extension for scripting the developer's debugging session.
I provides ways to:
- write a live script directly in the debugger (and affecting the debug session)
- save/load scripts
- create debugging commands from scripts

My owner must be a spec debugger
"
Class {
	#name : 'StSindarinDebuggerScriptingPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'code',
		'resultInspection',
		'toolbar',
		'sindarinDebugger',
		'resultLabel',
		'hasUnsavedCodeChanges',
		'scriptNameInput',
		'scriptRepository',
		'scriptRepositoryChooser'
	],
	#category : 'NewTools-Sindarin-Tools-Presenters',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Presenters'
}

{ #category : 'visiting' }
StSindarinDebuggerScriptingPresenter >> accept: aVisitor [

	^ aVisitor visitSindarin: self
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> createCommandFromScript [
	self flag: 'todo'
]

{ #category : 'accessing' }
StSindarinDebuggerScriptingPresenter >> debuggerActionModel [
	^self debugger debuggerActionModel
]

{ #category : 'debugger extension' }
StSindarinDebuggerScriptingPresenter >> debuggerExtensionToolName [

	^ 'Scripts'
]

{ #category : 'layout' }
StSindarinDebuggerScriptingPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: self toolbarLayout expand: false;
		add: #scriptNameInput 
			expand: false
			fill: false
			padding: 2;
		add: #code;
		add: #resultLabel 
			expand: false 
			fill: false 
			padding: 5;
		add: #resultInspection;
		yourself
]

{ #category : 'accessing' }
StSindarinDebuggerScriptingPresenter >> defaultScriptRepository [
	^ SindarinDefaultScriptRepository
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> executeScript [

	| stream result model receiver evaluationContext |
	self debuggerActionModel preventUpdatesDuring: [ 
		stream := code text readStream.
		model := code interactionModel.
		receiver := model context receiver.
		evaluationContext := model context.
		result := receiver class compiler
			          source: stream;
			          context: evaluationContext;
			          receiver: receiver;
			          requestor: model;
			          failBlock: [ nil ];
			          evaluate.
		resultInspection model: result.
		resultInspection update ]
]

{ #category : 'accessing' }
StSindarinDebuggerScriptingPresenter >> hasUnsavedCodeChanges [

	^ hasUnsavedCodeChanges ifNil: [ hasUnsavedCodeChanges := false ]
]

{ #category : 'initialization' }
StSindarinDebuggerScriptingPresenter >> initializePresenters [
	scriptNameInput := self newTextInput.
	resultLabel := self newLabel.
	
	self initializeScriptRepository.
	self initializeScriptRepositoryChooser.
	
	code := self newCode.
	self loadLastScript.
	code syntaxHighlight: true.
	code whenTextChangedDo: [
			hasUnsavedCodeChanges := true.
			self updateLabel ].
	self updateCode.
	resultInspection := nil inspectionRaw: self.
	resultInspection owner: self.
	self initializeToolbar.
	self updateLabel.
	

]

{ #category : 'initialization' }
StSindarinDebuggerScriptingPresenter >> initializeScriptRepository [
	|scriptName|
	
	scriptRepository := StSindarinDebuggerScriptRepositoryPresenter newApplication: self application.
	scriptRepository repository: self defaultScriptRepository. 
	
	scriptRepository whenLoadButtonDo: [ 
		scriptName := scriptRepository chooseElement.
		scriptName ifNotNil: [
			scriptNameInput text: scriptName .	
			code text: (scriptRepository loadScript: scriptName) .
			hasUnsavedCodeChanges := false.
	
			self updateLabel .
			self updatePresenter .
		].
	
		self layout: self defaultLayout.
	].

	scriptRepository whenCancelButtonDo: [ 
		self layout: self defaultLayout.
	]
]

{ #category : 'initialization' }
StSindarinDebuggerScriptingPresenter >> initializeScriptRepositoryChooser [
	
	scriptRepositoryChooser := StSindarinDebuggerScriptRepositoryChooserPresenter newApplication: self application.
	scriptRepositoryChooser 
		findRepositories;
		whenSelectedItemChangedDo: [ :item | 
			self saveLastScript.
			scriptRepository repository: item .
			self loadLastScript.
			self updateLabel.
		].
	
	
]

{ #category : 'initialization' }
StSindarinDebuggerScriptingPresenter >> initializeToolbar [
	
	toolbar := self newToolbar
		addStyle: 'stToolbar';
		beIcons;
		fillWith: self toolbarActions
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> loadLastScript [
	|script|
		
	script := (scriptRepository loadScript: 'Last updated') ifNil: ['sindarin stepOver'].
	scriptNameInput text: 'Last updated'.
	
	code text: script .
	
	hasUnsavedCodeChanges := false.
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> loadScript [	
	self layout: self loadScriptLayout.
	
	scriptRepository applyFilter.
	
	"check self initializeScriptRepository for loading script logic"
]

{ #category : 'layout' }
StSindarinDebuggerScriptingPresenter >> loadScriptLayout [ 
	^ SpBoxLayout newTopToBottom
		add: self toolbarLayout expand: false;
		add: #scriptRepository;
		yourself
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> removeScriptCommand [
	self flag: 'todo'
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> saveLastScript [
	scriptRepository saveScript: 'Last updated' code: code text.
	
	hasUnsavedCodeChanges := false.
	self updateLabel 
]

{ #category : 'actions' }
StSindarinDebuggerScriptingPresenter >> saveScript [

	scriptRepository saveScript: (scriptNameInput text) code: (code text).

	hasUnsavedCodeChanges := false.
	self updateLabel 
]

{ #category : 'accessing' }
StSindarinDebuggerScriptingPresenter >> setModelBeforeInitialization: aStDebugger [
	"My original model is the debugger presenter that I extend"
	debugger := aStDebugger.
	sindarinDebugger := aStDebugger sindarinDebugger
]

{ #category : 'accessing' }
StSindarinDebuggerScriptingPresenter >> sindarin [
	^sindarinDebugger 
]

{ #category : 'building' }
StSindarinDebuggerScriptingPresenter >> toolbarActions [
	| group |
	group := (CmCommandGroup named: 'Toolbar') asSpecGroup.
	
	group register: (SindarinRunScriptCommand forSpecContext: self).
	group register: (SindarinSaveScriptCommand forSpecContext: self).
	group register: (SindarinLoadScriptCommand forSpecContext: self).
	group register: (SindarinCreateCommandFromScriptCommand forSpecContext: self).
	group register: (SindarinRemoveCommandCommand forSpecContext: self).

	
	^ group
]

{ #category : 'layout' }
StSindarinDebuggerScriptingPresenter >> toolbarLayout [
	^ SpBoxLayout newLeftToRight
		add: #toolbar expand: false;
		add: #scriptRepositoryChooser;
		yourself.
]

{ #category : 'initialization' }
StSindarinDebuggerScriptingPresenter >> updateCode [

	| interactionModel |
	interactionModel := StSindarinContextInteractionModel on:
		                    self debuggerActionModel interruptedContext.
	interactionModel addBinding:
		(WorkspaceVariable key: #sindarin value: self sindarin).
	code interactionModel: interactionModel
]

{ #category : 'updating' }
StSindarinDebuggerScriptingPresenter >> updateLabel [

	self hasUnsavedCodeChanges ifTrue: [
		resultLabel label: '*unsaved script'.
		resultLabel addStyle: 'headerError'.
		^ self ].
	resultLabel label: 'Execute script to see results'.
	resultLabel addStyle: 'header'.
	resultLabel removeStyle: 'headerError'
]

{ #category : 'initialization' }
StSindarinDebuggerScriptingPresenter >> updatePresenter [

	self updateCode.
	super updatePresenter
]

{ #category : 'updating' }
StSindarinDebuggerScriptingPresenter >> windowIsClosing [ 
	self saveLastScript.
	super windowIsClosing.
]
