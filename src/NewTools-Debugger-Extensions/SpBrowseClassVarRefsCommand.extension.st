Extension { #name : 'SpBrowseClassVarRefsCommand' }

{ #category : '*NewTools-Debugger-Extensions' }
SpBrowseClassVarRefsCommand >> dynamicDebuggerContext: aStDebugger [
	^aStDebugger stackSelectionReceiverClass
]
