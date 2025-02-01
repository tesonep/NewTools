Extension { #name : 'SpMorphicBackend' }

{ #category : '*NewTools-Debugger-Morphic' }
SpMorphicBackend >> spawnNewDebugSessionForSpecBackend: aDebugSession [

	^ (StDebugger debugSessionClass newFromSession: aDebugSession)
		  backend: self;
		  yourself 
]
