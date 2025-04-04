Extension { #name : 'RBPackageEnvironment' }

{ #category : '*NewTools-MethodBrowsers' }
RBPackageEnvironment >> scopeListOrder [

	^ 2
]

{ #category : '*NewTools-MethodBrowsers' }
RBPackageEnvironment >> selectMessagesFrom: aCollectionOfCompiledMethod [ 
	"Answer a <Collection> of <CompiledMethod> present in the receiver"

	^ self packages flatCollect: [ : aPackage | 
		aCollectionOfCompiledMethod select: [ : cm | 
			aPackage
				includesSelector: cm selector 
				ofClass: cm methodClass ] ].
]
