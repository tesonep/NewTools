Extension { #name : 'StInheritanceDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
StInheritanceDependency >> browseIn: aBrowser [

	aBrowser selectClass: self theClass
]

{ #category : '*NewTools-DependencyAnalyser-UI' }
StInheritanceDependency >> nodeClass [
	^ StInheritanceDependencyNode
]
