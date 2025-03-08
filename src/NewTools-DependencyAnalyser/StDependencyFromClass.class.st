"
A PDDependencyFromClass is a dependency from the class. The source class is stored in the inst var.
"
Class {
	#name : 'StDependencyFromClass',
	#superclass : 'StPackageDependency',
	#instVars : [
		'theClass'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'comparing' }
StDependencyFromClass >> <= other [
	^ self theClass <= other theClass
]

{ #category : 'accessing' }
StDependencyFromClass >> theClass [
	^ theClass
]

{ #category : 'accessing' }
StDependencyFromClass >> theClass: aClass [
	theClass := aClass
]
