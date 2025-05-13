Class {
	#name : 'StDebuggerSessionPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'sessionInspector'
	],
	#category : 'NewTools-Debugger-View',
	#package : 'NewTools-Debugger',
	#tag : 'View'
}

{ #category : 'debugger extension' }
StDebuggerSessionPresenter >> debuggerExtensionToolName [
	^'Session'
]

{ #category : 'layout' }
StDebuggerSessionPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #sessionInspector;
		  yourself
]

{ #category : 'layout' }
StDebuggerSessionPresenter >> initializePresenters [

	sessionInspector := (StDebuggerMetaSession forDebugger: debugger) inspectionRaw: self
]
