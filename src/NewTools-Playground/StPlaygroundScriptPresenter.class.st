Class {
	#name : 'StPlaygroundScriptPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'bt1',
		'bt2',
		'bt3',
		'bt4',
		'parent',
		'currentClass',
		'listClass',
		'text',
		'listMethode',
		'script'
	],
	#category : 'NewTools-Playground-View',
	#package : 'NewTools-Playground',
	#tag : 'View'
}

{ #category : 'instance creation' }
StPlaygroundScriptPresenter class >> newApplication: anApplication model: anModelPresenter script: aPlaygroundScript [

	^ self basicNew
		application: anApplication;
		setModelBeforeInitialization: anModelPresenter;
		script: aPlaygroundScript;
		initialize;
		yourself
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> actionChangeClassInPlayground [
		parent script currentClass: currentClass.
		parent script basicInit.
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> actionCreateNewPlaygroundButton [
	| stPlay |
		stPlay := StPlaygroundPresenter openContents: 'this'.
		stPlay presenter firstPage script currentClass: currentClass.
		stPlay presenter firstPage interactionModel removeBindingNamed: 'this'.
		stPlay presenter firstPage script basicInit
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> actionSaveClassButton [
	script saveClassByText: text text. 
	listClass items: (PackageOrganizer default packageNamed: 'NewTools-Playground-Save') definedClasses asArray
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> actionSaveMethodButton [

	self textIsMethode ifTrue: [ ^ self ].
	script
		currentClass: currentClass;
		newMethod: text text.
	listMethode items:
		((currentClass allMethods collect: [ :aMethode | aMethode name ])
			 select: [ :aMethode | aMethode beginsWith: currentClass name ])
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> currentClass [
	^ currentClass
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> currentClass: aClass [
	currentClass := aClass
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> defaultLayout [ 
	^ (SpBoxLayout newLeftToRight
	
	add: text withConstraints: [:constaints | constaints height: 150; width: 500];
	add: (SpBoxLayout newTopToBottom 
		add: (SpBoxLayout newLeftToRight 
					add: listClass ; 
					add: listMethode;
					yourself
				) withConstraints: [:constaints | constaints height: 400; width: 50];
		add: (SpBoxLayout newLeftToRight 
					add: bt1 withConstraints: [:constaints | constaints width: 215];  
					add: bt2 withConstraints: [:constaints | constaints width: 215]; 
					yourself
				);
		add: (SpBoxLayout newLeftToRight 
					add: bt3 withConstraints: [:constaints | constaints width: 215];
					add: bt4 withConstraints: [:constaints | constaints width: 215];
					yourself
				);yourself);
	
	yourself).
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> getAClassBySelection: aSelection [
	|tmp|
	tmp := (((PackageOrganizer default packageNamed: 'NewTools-Playground-Save') definedClasses asArray) select: 
			[ :aMethode | aMethode asString literalEqual: aSelection asString ]).
	
	^ tmp first
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> getAMethodeBySelection: aSelection [
	^ (currentClass allMethods select: 
			[ :aMethode | aMethode name literalEqual: aSelection asString ]) first
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> initialize [
	super initialize.
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> initializeButtons [

	bt1 := self newButton.
	bt2 := self newButton.
	bt3 := self newButton.
	bt4 := self newButton.

	bt1 label: 'save the current class'.
	bt2 label: 'save the current method'.
	bt3 label: 'open current class in Play'.
	bt4 label: 'change current class your playground'.

	bt1 action: [ self actionSaveClassButton ].
	bt2 action: [ self actionSaveMethodButton ].
	bt3 action: [
		 ].
	bt4 action: [
		parent script currentClass: currentClass.
		parent script basicInit.
	]
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> initializeClassesList [
	|allClass|
	listClass := self newColumnView.
	allClass := ((PackageOrganizer default packageNamed: 'NewTools-Playground-Save') definedClasses ).
	allClass add: script currentClass.
	
	listClass addColumnTitle: 'class from playground save' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass asString ];
			whenSelectedDo: [ :selection | 
				currentClass := (self getAClassBySelection: selection).
				text text: currentClass definitionString.
				text interactionModel:(SpCodeBehaviorInteractionModel on: currentClass).
				listMethode items: ((currentClass allMethods collect: [ :aMethode | aMethode name ])
				
				select: [ :aMethode | aMethode beginsWith: currentClass name ]).
			];
			items: allClass asArray.
	
	
		
		

]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> initializeMethodList [ 
	listMethode := self newColumnView.
	
	listMethode 
		addColumnTitle: 'instace methode'
		setup: [ :aPresenter | aPresenter newLabel ]
		bind: [ :aPresenter :aClass | aPresenter label: (aClass copyReplaceAll: (currentClass name , '>>#') with: '') ];
		whenSelectedDo: [ :selection |
				text text: (self getAMethodeBySelection: selection) sourceCode.
				text interactionModel:(SpCodeMethodInteractionModel on: (self getAMethodeBySelection: selection)).
		];
		items: ((currentClass allMethods collect: [ :aMethode | aMethode name ])
				 select: [ :aMethode | aMethode beginsWith: currentClass name ]).
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> initializePresenters [
	
	text := self newCode.

	currentClass := script currentClass.
	
	self initializeClassesList.
	self initializeMethodList.
	self initializeButtons.

	text text: script currentClass definitionString.
	
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter initialExtent: 950@550;
	title: self windowTitle.
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> script: aPlaygroundScript [
	script := aPlaygroundScript
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> setModelBeforeInitialization: aModel [
	parent := aModel.
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> textIsMethode [
	^ text text includesSubstring: '>>'.
]

{ #category : 'as yet unclassified' }
StPlaygroundScriptPresenter >> windowTitle [ 
	^ 'Page Script'
]
