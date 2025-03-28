Extension { #name : 'SpBrowseInstVarRefsCommand' }

{ #category : '*NewTools-Debugger-Extensions' }
SpBrowseInstVarRefsCommand >> dynamicDebuggerContext: aStDebugger [
	^aStDebugger stackSelectionReceiverClass
]
