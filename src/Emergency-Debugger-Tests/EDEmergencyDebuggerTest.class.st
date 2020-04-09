Class {
	#name : #EDEmergencyDebuggerTest,
	#superclass : #TestCase,
	#instVars : [
		'ed',
		'session',
		'currentDebuggingAPI',
		'debugAPI'
	],
	#category : #'Emergency-Debugger-Tests'
}

{ #category : #running }
EDEmergencyDebuggerTest >> configureDebugSession [

	"Configure a debug session and moves it to the following stack:
	EDMockObjectForTests>>m: 5
	EDMockObjectForTests>>m: 6
	EDMockObjectForTests>>m: 7
	EDMockObjectForTests>>m: 8
	EDMockObjectForTests>>m: 9
	EDMockObjectForTests>>m: 10
	EDMockObjectForTests>>m: 11
	EDMockObjectForTests>>m: 12
	EDMockObjectForTests>>m: 13
	EDMockObjectForTests>>m: 14
	EDMockObjectForTests>>m: 15
	EDMockObjectForTests>>m: 16
	EDMockObjectForTests>>m: 17
	EDMockObjectForTests>>m: 18
	EDMockObjectForTests>>m: 19
	EDMockObjectForTests>>m: 20
	[ EDMockObjectForTests new m: 20 ] in UndefinedObject>>DoIt"
	
	session stepThrough.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.	
	session stepOver.
	session stepOver.
	session stepInto.
	
	session stepOver.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.	
	session stepOver.
	session stepOver.
	session stepInto.
	
	session stepOver.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.	
	session stepOver.
	session stepOver.
	session stepInto.
	
	session stepOver.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.	
	session stepOver.
	session stepOver.
	session stepInto.
	
	session stepOver.
	session stepOver.
	session stepInto.
	session stepOver.
	session stepOver.
	session stepInto.	
	session stepOver.
	session stepOver.
	session stepInto.

]

{ #category : #running }
EDEmergencyDebuggerTest >> newEd [
	ed := EDEmergencyDebugger new.
	ed repl: EDMockREPLInterface new.
	ed displayInterface: EDMockDisplayInterface new.
	ed debug: session

]

{ #category : #running }
EDEmergencyDebuggerTest >> setUp [
	| context process |
	super setUp.	
	currentDebuggingAPI := EDEmergencyDebugger debugAPI.
	EDEmergencyDebugger debugAPI: nil.
	context := [ EDMockObjectForTests new m: 20 ] asContext.
	process := Process
		forContext: context
		priority: Processor userInterruptPriority.
	session := DebugSession
		named: 'test session'
		on: process
		startedAt: context.
	self configureDebugSession.
	debugAPI := EDDebuggingAPI attachTo: session.
	self newEd
]

{ #category : #running }
EDEmergencyDebuggerTest >> tearDown [
	EDEmergencyDebugger debugAPI: currentDebuggingAPI.
	session terminate.
	super tearDown
]

{ #category : #'debug API' }
EDEmergencyDebuggerTest >> testDebugAPI [
	|api|
	api := EDMockObjectForTests new.
	EDEmergencyDebugger debugAPI: api.
	self assert: EDEmergencyDebugger debugAPI identicalTo: api
	
]

{ #category : #'debug API' }
EDEmergencyDebuggerTest >> testDefaultDebugAPI [
	
	self assert: EDEmergencyDebugger debugAPI identicalTo: EDDebuggingAPI
	
]

{ #category : #setup }
EDEmergencyDebuggerTest >> testIsRunning [
	
	"This is a new Ed, we did not call #debug: so it is not running"
	self deny: EDEmergencyDebugger new isRunning.
	"This Ed, we called #debug: in the test setup so it is running"
	self assert: ed isRunning 
]

{ #category : #'api - stack' }
EDEmergencyDebuggerTest >> testMoveDownInStack [ 
	|selectionIndexBefore shortStackIndexBefore|
	selectionIndexBefore := ed stackSelectionIndex.
	shortStackIndexBefore := ed shortStackIndex.
	ed moveDownInStack.
	self assert: ed stackSelectionIndex 
			equals: ((selectionIndexBefore + 1) min: debugAPI stackSize).
	self assert: ed shortStackIndex equals: (shortStackIndexBefore + 1).
	self assert: ed methodVersionSelectionIndex equals: 0		
]

{ #category : #'api - stack' }
EDEmergencyDebuggerTest >> testMoveUpInStack [ 
	|selectionIndexBefore shortStackIndexBefore|
	selectionIndexBefore := ed stackSelectionIndex.
	shortStackIndexBefore := ed shortStackIndex.
	ed moveUpInStack.
	self assert: ed stackSelectionIndex equals: ((selectionIndexBefore - 1) max: 1).
	self assert: ed shortStackIndex equals: (shortStackIndexBefore - 1).
	self assert: ed methodVersionSelectionIndex equals: 0		
]

{ #category : #'api - stack' }
EDEmergencyDebuggerTest >> testShortStack [ 
	self assert: ed shortStack size equals: 5.	
	self assertCollection: (session stackOfSize: 5) hasSameElements: ed shortStack
]

{ #category : #setup }
EDEmergencyDebuggerTest >> testTerminate [
	
	ed terminate.
	self deny: ed isRunning 
]

{ #category : #'api - stack' }
EDEmergencyDebuggerTest >> testUpdateShortStackForDisplay [ 
	
]