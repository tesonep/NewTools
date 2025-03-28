Extension { #name : 'SpBrowseClassVariablesCommand' }

{ #category : '*NewTools-Debugger-Extensions' }
SpBrowseClassVariablesCommand >> dynamicDebuggerContext: aStDebugger [
	^aStDebugger stackSelectionReceiverClass
]
