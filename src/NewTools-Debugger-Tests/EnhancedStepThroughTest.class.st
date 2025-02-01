Class {
	#name : 'EnhancedStepThroughTest',
	#superclass : 'StepThroughTest',
	#category : 'NewTools-Debugger-Tests-Core',
	#package : 'NewTools-Debugger-Tests',
	#tag : 'Core'
}

{ #category : 'utilities' }
EnhancedStepThroughTest >> settingUpSessionAndProcessAndContextForBlock: aSetupBlock [

	super settingUpSessionAndProcessAndContextForBlock: aSetupBlock.

	session := EnhancedDebugSession
		           named: 'test session'
		           on: process
		           startedAt: context
]
