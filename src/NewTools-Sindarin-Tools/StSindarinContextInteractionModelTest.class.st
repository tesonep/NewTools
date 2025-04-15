Class {
	#name : 'StSindarinContextInteractionModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'sindarin'
	],
	#category : 'NewTools-Sindarin-Tools-Tests',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Tests'
}

{ #category : 'running' }
StSindarinContextInteractionModelTest >> setUp [

	super setUp.

	sindarin := SindarinDebugger debug: [
		            | var var2 var3 |
		            var := 0.
		            var2 := var + 2.
		            var3 := var2 squared ].
	"debugger := StDebugger debugSession: sindarin debugSession"
	
]

{ #category : 'running' }
StSindarinContextInteractionModelTest >> tearDown [

	sindarin terminate.
	super tearDown
]

{ #category : 'tests' }
StSindarinContextInteractionModelTest >> testCustomBindings [
	|interactionModel customBinding|
	customBinding := (WorkspaceVariable key: #sindarin value: sindarin).
			
	interactionModel := StSindarinContextInteractionModel on: sindarin context.
	interactionModel addBinding: customBinding.
	
	"The interaction model should return the direct value of the workspace variable"
	self assert: (interactionModel hasBindingOf: #sindarin).
	self assert: (interactionModel bindingOf: #sindarin) value identicalTo: sindarin 
	
]

{ #category : 'tests' }
StSindarinContextInteractionModelTest >> testIsScripting [
	self assert: StSindarinContextInteractionModel new isScripting
	
]
