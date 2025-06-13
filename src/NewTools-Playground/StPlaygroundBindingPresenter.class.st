Class {
	#name : 'StPlaygroundBindingPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'binding',
		'parent',
		'bindingName',
		'labelName',
		'bindingValue',
		'buttonAdd',
		'buttonClose'
	],
	#category : 'NewTools-Playground-View',
	#package : 'NewTools-Playground',
	#tag : 'View'
}

{ #category : 'accessing' }
StPlaygroundBindingPresenter class >> model: anModelPresenter [
	^ self basicNew 
		setModelBeforeInitialization: anModelPresenter;
		initialize
]

{ #category : 'layout' }
StPlaygroundBindingPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
			add: (SpBoxLayout new
				   add: (SpBoxLayout newLeftToRight hAlignCenter add: labelName ; yourself) ;
				   add: bindingName; 
				   yourself) withConstraints: [:contrain | contrain width: 75; height: 60; padding: 10];
		 	add: bindingValue;
			add: (SpBoxLayout newLeftToRight hAlignCenter ;
						add: buttonAdd; 
						add: buttonClose;
						yourself) withConstraints: [ :contrain | contrain width: 70; height: 30 ];
			
		   yourself
]

{ #category : 'initialization - deprecated' }
StPlaygroundBindingPresenter >> initializePresenter [ 
	bindingName := self newTextInput.
	labelName := self newLabel.
	labelName label: 'name'.

	bindingValue := self newCode.
	bindingValue interactionModel: SpCodeScriptingInteractionModel new.
	
	buttonAdd := self newButton.
	buttonAdd label: 'add'.
	buttonAdd action: [ bindingValue text: 'hello world' ].
	
	buttonClose := self newButton.
	buttonClose label: 'close'.
	buttonClose action: [ self delete ]

	
]

{ #category : 'accessing - model' }
StPlaygroundBindingPresenter >> setModelBeforeInitialization: aModel [
	parent := aModel.
]

{ #category : 'accessing' }
StPlaygroundBindingPresenter >> windowTitle [
	^ 'add / modif binding'
]
