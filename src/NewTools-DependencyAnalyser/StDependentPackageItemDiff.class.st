"
A PDDependentPackageItemDiff is a object which represent a dependent package who added/modified/removed from an old analysis.
"
Class {
	#name : 'StDependentPackageItemDiff',
	#superclass : 'StAbstractItemDiff',
	#instVars : [
		'parent'
	],
	#category : 'NewTools-DependencyAnalyser-Diff',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Diff'
}

{ #category : 'testing' }
StDependentPackageItemDiff >> hasChanged [
	^ self isNew or: [ self isRemoved ]
]

{ #category : 'accessing' }
StDependentPackageItemDiff >> parent [
	^ parent
]

{ #category : 'accessing' }
StDependentPackageItemDiff >> parent: anObject [
	parent := anObject
]

{ #category : 'printing' }
StDependentPackageItemDiff >> printOn: aStream [
	aStream
		nextPutAll: content packageName;
		nextPutAll: ' Parent : ';
		nextPutAll: self parent packageName
]
