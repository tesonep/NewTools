Class {
	#name : 'StSindarinDebuggerScriptSaverTest',
	#superclass : 'TestCase',
	#instVars : [
		'scriptSaver'
	],
	#category : 'NewTools-Sindarin-Tools-Tests',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Tests'
}

{ #category : 'running' }
StSindarinDebuggerScriptSaverTest >> setUp [
	super setUp.
]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testScripts [
	StSindarinDebuggerScriptSaver scripts 
]
