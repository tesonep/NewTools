Class {
	#name : 'EnhancedStepThroughWithHaltingBlockTest',
	#superclass : 'StepThroughTest',
	#category : 'NewTools-Debugger-Tests-Core',
	#package : 'NewTools-Debugger-Tests',
	#tag : 'Core'
}

{ #category : 'utilities' }
EnhancedStepThroughWithHaltingBlockTest >> settingUpSessionAndProcessAndContextForBlock: aBlock [

	super settingUpSessionAndProcessAndContextForBlock: aBlock.
	session :=  EnhancedDebugSessionWithHaltingBlock named: 'test session' on: process startedAt: context
	

]
