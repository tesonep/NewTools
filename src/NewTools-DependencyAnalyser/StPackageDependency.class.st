"
A PDPackageDependency is a dependency between two packages.

	source:		the source PDPackage 
	target:	      the target PDPackage

"
Class {
	#name : 'StPackageDependency',
	#superclass : 'Object',
	#instVars : [
		'source',
		'target'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StPackageDependency class >> from: aSourcePackage to: aDestinationPackage [
	^ self new initializeFrom: aSourcePackage to: aDestinationPackage
]

{ #category : 'displaying' }
StPackageDependency >> displayString [

	^ String streamContents: [ :stream | self printReasonOn: stream ]
]

{ #category : 'comparing' }
StPackageDependency >> hash [
	^ source hash bitXor: target hash
]

{ #category : 'initialization' }
StPackageDependency >> initializeFrom: aSourcePackage to: aTargetPackage [
	source := aSourcePackage.
	target := aTargetPackage
]

{ #category : 'testing' }
StPackageDependency >> isExtensionDependency [
	^ false
]

{ #category : 'testing' }
StPackageDependency >> isExternal [
	^ self isInternal not
]

{ #category : 'testing' }
StPackageDependency >> isInheritanceDependency [
	^ false
]

{ #category : 'testing' }
StPackageDependency >> isInternal [
	^ self source = self target
]

{ #category : 'testing' }
StPackageDependency >> isMessageSendDependency [
	^ false
]

{ #category : 'testing' }
StPackageDependency >> isReferenceDependency [
	^ false
]

{ #category : 'testing' }
StPackageDependency >> isTraitDependency [
	^ false
]

{ #category : 'accessing' }
StPackageDependency >> numberOfDependencies [
	^ 1
]

{ #category : 'accessing' }
StPackageDependency >> packageName [
	^ target packageName
]

{ #category : 'printing' }
StPackageDependency >> printOn: aStream [
	self printReasonOn: aStream
]

{ #category : 'printing' }
StPackageDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: source packageName;
		nextPutAll: ' -> ';
		nextPutAll: target packageName
]

{ #category : 'printing' }
StPackageDependency >> printShortReasonOn: aStream [
	self printReasonOn: aStream
]

{ #category : 'accessing' }
StPackageDependency >> reason [
	^ String streamContents: [ :stream | self printReasonOn: stream ]
]

{ #category : 'accessing' }
StPackageDependency >> source [
	^ source
]

{ #category : 'accessing' }
StPackageDependency >> target [
	^ target
]
