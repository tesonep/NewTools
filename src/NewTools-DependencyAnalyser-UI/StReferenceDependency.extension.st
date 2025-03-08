Extension { #name : 'StReferenceDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
StReferenceDependency >> browseIn: aBrowser [

	aBrowser selectMethod: self method
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
StReferenceDependency >> nodeClass [
	^ StReferenceDependencyNode
]
