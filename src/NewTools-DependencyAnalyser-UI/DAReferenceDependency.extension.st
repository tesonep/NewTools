Extension { #name : 'DAReferenceDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAReferenceDependency >> browseIn: aBrowser [

	aBrowser selectMethod: self method
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAReferenceDependency >> nodeClass [
	^ DAReferenceDependencyNode
]
