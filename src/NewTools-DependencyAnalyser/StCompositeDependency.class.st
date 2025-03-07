"
A PDCompositeDependency is a composite dependency. A composite pattern is using.

Actually in all case this dependency contains the dependencies between two packages and the instance variable dependencies contains all the type of dependencies (Extension, Inheritance, Reference, Trait).
"
Class {
	#name : 'StCompositeDependency',
	#superclass : 'StPackageDependency',
	#instVars : [
		'dependencies'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'adding' }
StCompositeDependency >> add: aDependency [
	dependencies add: aDependency
]

{ #category : 'accessing' }
StCompositeDependency >> children [
	^ self dependencies
]

{ #category : 'testing' }
StCompositeDependency >> containsOnlyExtensionDependency [
	(self dependencies isEmpty ) ifTrue: [ ^ false ].
	 ^ self dependencies allSatisfy: [ :dependency | dependency isExtensionDependency ]
]

{ #category : 'accessing' }
StCompositeDependency >> dependencies [
	^ dependencies
]

{ #category : 'accessing' }
StCompositeDependency >> dependenciesFrom: aClass [

	^ dependencies select: [ :reference | reference theClass = aClass ]
]

{ #category : 'testing' }
StCompositeDependency >> dependenciesWithoutExtensionDependency [
	^ dependencies reject: [ :dependency | dependency isExtensionDependency ]
]

{ #category : 'accessing' }
StCompositeDependency >> extensionDependencies [
 	^ dependencies select: [ :each | each isExtensionDependency ]
]

{ #category : 'accessing' }
StCompositeDependency >> extensionDependenciesSize [
	^ self dependencies sum: [ :dependency |
			dependency isExtensionDependency
				ifTrue: [ 1 ]
				ifFalse: [ 0 ] ]
]

{ #category : 'initialization' }
StCompositeDependency >> initializeFrom: aSourcePackage to: aTargetPackage [

	super initializeFrom: aSourcePackage to: aTargetPackage.
	dependencies := OrderedCollection new
]

{ #category : 'accessing' }
StCompositeDependency >> numberOfDependencies [
	^ dependencies size
]

{ #category : 'printing' }
StCompositeDependency >> printReasonOn: aStream [
	aStream nextPutAll: dependencies size asString; nextPutAll: ' dependencies: '.
	dependencies
		do: [ :each | each printReasonOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : 'printing' }
StCompositeDependency >> printShortReasonOn: aStream [
	aStream nextPutAll: dependencies size asString
]

{ #category : 'accessing' }
StCompositeDependency >> referenceDependencies [
 	^ dependencies select: [ :each | each isReferenceDependency ]
]

{ #category : 'accessing' }
StCompositeDependency >> referenceDependenciesFrom: aClass [
	| references |
	references := self referenceDependencies.

	^ references select: [ :reference | reference theClass = aClass ]
]
