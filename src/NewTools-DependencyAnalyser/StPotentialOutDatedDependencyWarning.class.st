"
Warning signaled when a dependency manually declared has no match in potential dependencies.
"
Class {
	#name : 'StPotentialOutDatedDependencyWarning',
	#superclass : 'Warning',
	#instVars : [
		'package',
		'dependency'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'signaling' }
StPotentialOutDatedDependencyWarning class >> signalDependency: dependencyName on: aPackageName [
	^ self basicNew
		initializeWithDependency: dependencyName on: aPackageName;
		signal;
		yourself
]

{ #category : 'comparing' }
StPotentialOutDatedDependencyWarning >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ (package == anObject package) and: [ dependency == anObject dependency ]
]

{ #category : 'accessing' }
StPotentialOutDatedDependencyWarning >> dependency [
	^ dependency
]

{ #category : 'comparing' }
StPotentialOutDatedDependencyWarning >> hash [
	^ package hash bitXor: dependency hash
]

{ #category : 'initialization' }
StPotentialOutDatedDependencyWarning >> initializeWithDependency: aDependencyName on: aPackageName [
	dependency := aDependencyName.
	package := aPackageName
]

{ #category : 'accessing' }
StPotentialOutDatedDependencyWarning >> messageText [
	^ messageText
		ifNil: [ package , ': ' , dependency , ' dependency declared in the package Manifest as manuallyResolvedDependencies not detected as a dependency!' ]
]

{ #category : 'accessing' }
StPotentialOutDatedDependencyWarning >> package [
	^ package
]
