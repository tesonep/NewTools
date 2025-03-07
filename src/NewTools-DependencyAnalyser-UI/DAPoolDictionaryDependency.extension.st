Extension { #name : 'DAPoolDictionaryDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAPoolDictionaryDependency >> browseIn: aSystemBrowser [

	aSystemBrowser selectClass: self theClass
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAPoolDictionaryDependency >> nodeClass [
	^ DAPoolDictionaryDependencyNode
]
