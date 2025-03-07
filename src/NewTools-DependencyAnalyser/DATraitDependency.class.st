"
A PDTraitDependency is a trait dependency between two packages. 


Instance Variable
	trait:		the trait
"
Class {
	#name : 'DATraitDependency',
	#superclass : 'DADependencyFromClass',
	#instVars : [
		'trait'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'testing' }
DATraitDependency >> isTraitDependency [
	^ true
]

{ #category : 'printing' }
DATraitDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: ' uses ';
		print: self trait name
]

{ #category : 'accessing' }
DATraitDependency >> trait [
	^ trait
]

{ #category : 'accessing' }
DATraitDependency >> trait: aTrait [
	trait := aTrait
]
