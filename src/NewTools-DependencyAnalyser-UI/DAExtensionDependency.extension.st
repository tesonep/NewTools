Extension { #name : 'DAExtensionDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAExtensionDependency >> browseIn: aSystemBrowser [

	aSystemBrowser selectMethod: self method
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAExtensionDependency >> nodeClass [
	^ DAExtensionDependencyNode
]
