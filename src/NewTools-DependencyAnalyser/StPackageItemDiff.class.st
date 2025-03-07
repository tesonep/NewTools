"
A PDAbstractItemDiff is a object which represent a package who added/modified/removed from an old analysis.
"
Class {
	#name : 'StPackageItemDiff',
	#superclass : 'StAbstractItemDiff',
	#category : 'NewTools-DependencyAnalyser-Diff',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Diff'
}

{ #category : 'accessing' }
StPackageItemDiff >> dependencies [
	 ^ self content dependentPackages
]

{ #category : 'testing' }
StPackageItemDiff >> hasChanged [
	^ diff dependentPackagesDiff
		detect: [ :each | each parent = self content and: [ each hasChanged ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : 'printing' }
StPackageItemDiff >> printOn: aStream [
	aStream
		nextPutAll: content packageName
]
