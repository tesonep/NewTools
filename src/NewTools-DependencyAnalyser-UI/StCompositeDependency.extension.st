Extension { #name : 'StCompositeDependency' }

{ #category : '*NewTools-DependencyAnalyser-UI' }
StCompositeDependency >> nodeClass [
	^ self dependencies first isMessageSendDependency
		ifTrue: [ StManuallyAddedDependentPackageNode ]
		ifFalse: [ StDependentPackageNode ]
]
