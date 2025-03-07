"
A PDDependencyItemDiff is a object which represent a dependent package who added/removed from an old analysis.
"
Class {
	#name : 'DADependencyItemDiff',
	#superclass : 'DAAbstractItemDiff',
	#category : 'NewTools-DependencyAnalyser-Diff',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Diff'
}

{ #category : 'testing' }
DADependencyItemDiff >> hasChanged [
	^ self
]

{ #category : 'printing' }
DADependencyItemDiff >> printOn: aStream [

	aStream print: self content
]
