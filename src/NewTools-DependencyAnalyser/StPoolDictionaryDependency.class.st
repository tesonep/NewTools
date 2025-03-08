"
I am a dependency produced by a pool Dictionary.
For example the following class CharacterBlock depends on the Text package because it uses TextConstants that is defined in it.

Rectangle subclass: #CharacterBlock
	instanceVariableNames: 'stringIndex text textLine'
	classVariableNames: ''
	poolDictionaries: 'TextConstants'
	package: 'Text-Scanning-Base'
"
Class {
	#name : 'StPoolDictionaryDependency',
	#superclass : 'StDependencyFromClass',
	#instVars : [
		'poolDictionary'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'accessing' }
StPoolDictionaryDependency >> poolDictionary [
	^ poolDictionary
]

{ #category : 'accessing' }
StPoolDictionaryDependency >> poolDictionary: aClass [
	poolDictionary := aClass
]

{ #category : 'printing' }
StPoolDictionaryDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: ' uses pool dictionary ';
		nextPutAll: self poolDictionary name
]
