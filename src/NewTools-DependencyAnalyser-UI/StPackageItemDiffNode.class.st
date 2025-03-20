"
A PDPackageNode is used to display a package diff in a tree.
"
Class {
	#name : 'StPackageItemDiffNode',
	#superclass : 'Object',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StPackageItemDiffNode >> icon [
	self content isNew ifTrue: [ ^ self iconNamed: #changeAdd ].
	self content isRemoved ifTrue: [^ self iconNamed: #smallCancel].
	^ self iconNamed: #forward
]
