"
A PDInheritanceDependency is an inheritance dependency between two packages.

	superclass:		the superclass that includes in the target PDPackag

"
Class {
	#name : 'StInheritanceDependency',
	#superclass : 'StDependencyFromClass',
	#instVars : [
		'superclass'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'testing' }
StInheritanceDependency >> isInheritanceDependency [
	^ true
]

{ #category : 'printing' }
StInheritanceDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: ' inherits from ';
		nextPutAll: self superclass name
]

{ #category : 'accessing' }
StInheritanceDependency >> superclass [
	^ superclass
]

{ #category : 'accessing' }
StInheritanceDependency >> superclass: aClass [
	superclass := aClass
]
