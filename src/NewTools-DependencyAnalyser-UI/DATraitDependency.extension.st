Extension { #name : 'DATraitDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
DATraitDependency >> browseIn: aSystemBrowser [

	aSystemBrowser selectClass: self theClass
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
DATraitDependency >> nodeClass [
	^ DATraitDependencyNode
]
