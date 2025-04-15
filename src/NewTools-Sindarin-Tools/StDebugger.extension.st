Extension { #name : 'StDebugger' }

{ #category : '*NewTools-Sindarin-Tools' }
StDebugger >> sindarinDebugger [
	^ SindarinDebugger attachTo: self session
]

{ #category : '*NewTools-Sindarin-Tools' }
StDebugger >> sindarinTargetNode [

	^ self sindarinDebugger targetNodeFor: self code selectionInterval
]
