Extension { #name : 'StExtensionDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
StExtensionDependency >> browseIn: aSystemBrowser [

	aSystemBrowser selectMethod: self method
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
StExtensionDependency >> nodeClass [
	^ StExtensionDependencyNode
]
