Extension { #name : 'StPoolDictionaryDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
StPoolDictionaryDependency >> browseIn: aSystemBrowser [

	aSystemBrowser selectClass: self theClass
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
StPoolDictionaryDependency >> nodeClass [
	^ StPoolDictionaryDependencyNode
]
