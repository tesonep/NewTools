Extension { #name : 'DACompositeDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
DACompositeDependency >> nodeClass [
	^ self dependencies first isMessageSendDependency
		ifTrue: [ DAManuallyAddedDependentPackageNode ]
		ifFalse: [ DADependentPackageNode ]
]
