Extension { #name : 'StTraitDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
StTraitDependency >> browseIn: aSystemBrowser [

	aSystemBrowser selectClass: self theClass
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
StTraitDependency >> nodeClass [
	^ StTraitDependencyNode
]
