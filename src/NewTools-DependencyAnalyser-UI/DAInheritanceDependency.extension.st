Extension { #name : 'DAInheritanceDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAInheritanceDependency >> browseIn: aBrowser [

	aBrowser selectClass: self theClass
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
DAInheritanceDependency >> nodeClass [
	^ DAInheritanceDependencyNode
]
