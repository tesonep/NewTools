Class {
	#name : 'StThreadSafeTranscriptTest',
	#superclass : 'TestCase',
	#instVars : [
		't'
	],
	#category : 'NewTools-Transcript-Tests',
	#package : 'NewTools-Transcript-Tests'
}

{ #category : 'running' }
StThreadSafeTranscriptTest >> setUp [ 

	super setUp.
	t := StThreadSafeTranscript createTestingInstance
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testAppend [ 

	t show: 'AB'.
	self assert: t contents equals: 'AB'.
	t show: 'C'.
	self assert: t contents equals: 'ABC'
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPut [

	t nextPut: $a.
	t << 'toto'.
	t cr.
	t nextPutAll: 'tintin'.
	self assert: t contents equals: 'atoto
tintin' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutIsOverMaxEntry [

	t maxEntry: 1.
	t << 'A'.
	t << 'B'.
	self assert: t contents equals: 'B' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutIsUnderMaxEntry [

	t maxEntry: 5.
	t << 'toto'.
	self assert: t contents equals: 'toto' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testShow [

	t show: 'toto'.
	self assert: t contents equals: 'toto' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testShowAndClear [

	t show: 'toto'.
	self assert: t contents equals: 'toto'.
	t clear.
	self assert: t contents isEmpty
]
