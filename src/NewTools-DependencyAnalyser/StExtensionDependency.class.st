"
A PDExtensionDependency is an extension dependency between two packages.

Instance Variables
	selector:		the selector 
	method : 		the CompiledMethod
		
"
Class {
	#name : 'StExtensionDependency',
	#superclass : 'StDependencyFromClass',
	#instVars : [
		'selector',
		'method'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'testing' }
StExtensionDependency >> isExtensionDependency [
	^ true
]

{ #category : 'accessing' }
StExtensionDependency >> method [
	^ method
]

{ #category : 'accessing' }
StExtensionDependency >> method: anObject [
	method := anObject
]

{ #category : 'printing' }
StExtensionDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: '>>';
		print: self selector;
		nextPutAll: ' (extension)'
]

{ #category : 'accessing' }
StExtensionDependency >> selector [
	^ selector
]

{ #category : 'accessing' }
StExtensionDependency >> selector: aSelector [
	selector := aSelector
]
