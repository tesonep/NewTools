"
A PDReferenceDependency is a reference dependency between two packages. 

Instance Variables
	reference:		the reference class
	selector:		the selector that references the class
	method : 		the CompiledMethod

"
Class {
	#name : 'StReferenceDependency',
	#superclass : 'StDependencyFromClass',
	#instVars : [
		'selector',
		'reference',
		'method'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'testing' }
StReferenceDependency >> isReferenceDependency [
	^ true
]

{ #category : 'accessing' }
StReferenceDependency >> method [
	^ method
]

{ #category : 'accessing' }
StReferenceDependency >> method: anObject [
	method := anObject
]

{ #category : 'printing' }
StReferenceDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: '>>';
		print: self selector;
		nextPutAll: ' references ';
		print: self reference
]

{ #category : 'accessing' }
StReferenceDependency >> reference [
	^ reference
]

{ #category : 'accessing' }
StReferenceDependency >> reference: aClass [
	reference := aClass
]

{ #category : 'accessing' }
StReferenceDependency >> selector [
	^ selector
]

{ #category : 'accessing' }
StReferenceDependency >> selector: aSymbol [
	selector := aSymbol
]
