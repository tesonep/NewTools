"
A PDTraitDependency is a trait dependency between two packages. 


Instance Variable
	trait:		the trait
"
Class {
	#name : 'StTraitDependency',
	#superclass : 'StDependencyFromClass',
	#instVars : [
		'trait'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'testing' }
StTraitDependency >> isTraitDependency [
	^ true
]

{ #category : 'printing' }
StTraitDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: ' uses ';
		print: self trait name
]

{ #category : 'accessing' }
StTraitDependency >> trait [
	^ trait
]

{ #category : 'accessing' }
StTraitDependency >> trait: aTrait [
	trait := aTrait
]
