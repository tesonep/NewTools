Extension { #name : 'DebugPoint' }

{ #category : '*NewTools-Debugger' }
DebugPoint class >> allInstalledInMethod: aCompiledMethod [
	"We don't expect this code to be slow: there are rarely thousands of breakpoints installed in a running system. Therefore the enumerating of all links of all breakpoints should be quick because few breakpoints are involved. Future work could store install-time metadata in debug points to simplify this."
	^ self all select: [ :dp |
		  dp link nodes anySatisfy: [ :n |
			  n methodNode compiledMethod == aCompiledMethod method ] ]
]
