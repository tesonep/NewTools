Extension { #name : 'Package' }

{ #category : '*NewTools-DependencyAnalyser' }
Package >> ignoredDependencies [

	^ self packageManifestOrNil
		ifNil: [ #() ]
		ifNotNil: #ignoredDependencies
]

{ #category : '*NewTools-DependencyAnalyser' }
Package >> manuallyResolvedDependencies [

	^ self packageManifestOrNil
		ifNil: [ #() ]
		ifNotNil: #manuallyResolvedDependencies
]
