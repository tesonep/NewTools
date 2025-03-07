"
A PDDependencyItemDiff is a object which represent a dependent package who added/removed from an old analysis.
"
Class {
	#name : 'StDependencyItemDiff',
	#superclass : 'StAbstractItemDiff',
	#category : 'NewTools-DependencyAnalyser-Diff',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Diff'
}

{ #category : 'testing' }
StDependencyItemDiff >> hasChanged [
	^ self
]

{ #category : 'printing' }
StDependencyItemDiff >> printOn: aStream [

	aStream print: self content
]
