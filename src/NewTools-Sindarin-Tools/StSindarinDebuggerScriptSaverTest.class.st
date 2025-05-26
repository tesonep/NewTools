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
	
	StSindarinDebuggerScriptSaver clearScripts.
]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testAddMultipleScriptsStoresEachCorrectly [
	"We assume that the setup clears the scripts dictionary"

	|name1 name2 code1 code2|
	name1 := '01'.
	code1 := '"code01"'.
	name2 := '02'.
	code2 := '"code02'.
	
	StSindarinDebuggerScriptSaver saveScript: name1 code: code1.
	StSindarinDebuggerScriptSaver saveScript: name2 code: code2.
	
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: name1 ).
	self assert: (StSindarinDebuggerScriptSaver loadScript: name1 ) identicalTo: code1 .
	
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: name2 ).
	self assert: (StSindarinDebuggerScriptSaver loadScript: name2 ) identicalTo: code2 .

]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testAddScriptStoresCodeCorrectly [
	"We assume that the setup clears the scripts dictionary"
	
	|scriptName script|
	
	scriptName := 'Script01'.
	script := '"code de script"'.
	
	StSindarinDebuggerScriptSaver saveScript: scriptName code: script .
	
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName).
	self assert: (StSindarinDebuggerScriptSaver loadScript: scriptName ) identicalTo: script .
]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testClearScriptsEmptiesDictionary [
	"We assume that the setup clears the scripts dictionary"
	
	|scriptName1 scriptName2 script|
	
	scriptName1 := '01'.
	scriptName2 := '02'.
	script := '"code"'.
	
	StSindarinDebuggerScriptSaver saveScript: scriptName1 code: script.
	StSindarinDebuggerScriptSaver saveScript: scriptName2 code: script.
	
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName1).
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName2).
	
	StSindarinDebuggerScriptSaver clearScripts.
	
	self deny: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName1).
	self deny: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName2).
]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testLookupNonexistentScriptReturnsNil [
	"We assume that the setup clears the scripts dictionary"
	
	|notExistingScriptName|
	
	notExistingScriptName := 'Script404'.
	
	self deny: (StSindarinDebuggerScriptSaver scriptsNames includes: notExistingScriptName).
	self assert: ((StSindarinDebuggerScriptSaver loadScript: notExistingScriptName) isNil).
]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testOverwriteScriptReplacesCode [
	"We assume that the setup clears the scripts dictionary"
	
	|scriptName oldScript newScript|
	scriptName := 'script01'.
	oldScript := '"ancien code de script"'.
	newScript := '"nouveau code de script"'.
	
	StSindarinDebuggerScriptSaver saveScript: scriptName code: oldScript .
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName).
	self assert: (StSindarinDebuggerScriptSaver loadScript: scriptName ) identicalTo: oldScript .
	
	StSindarinDebuggerScriptSaver saveScript: scriptName code: newScript .
	self assert: (StSindarinDebuggerScriptSaver scriptsNames includes: scriptName).
	self assert: (StSindarinDebuggerScriptSaver loadScript: scriptName ) identicalTo: newScript .

]

{ #category : 'tests' }
StSindarinDebuggerScriptSaverTest >> testScriptsDictionaryIsInitialized [
	"We assume that the setup clears the scripts dictionary"
	
	self deny: (StSindarinDebuggerScriptSaver scripts isNil).
]
