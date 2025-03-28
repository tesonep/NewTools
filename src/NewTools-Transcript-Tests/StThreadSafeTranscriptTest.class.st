Class {
	#name : 'StThreadSafeTranscriptTest',
	#superclass : 'TestCase',
	#category : 'NewTools-Transcript-Tests',
	#package : 'NewTools-Transcript-Tests'
}

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPut [

	| t |
	t := StThreadSafeTranscript new.
	t nextPut: $a.
	t << 'toto'.
	t cr.
	t nextPutAll: 'tintin'.
	self assert: t contents equals: 'atoto
tintin' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutAfterClear [

	| t |
	t := StThreadSafeTranscript new clear.
	t nextPut: $a.
	t << 'toto'.
	t cr.
	t nextPutAll: 'tintin'.
	self assert: t contents equals: 'atoto
tintin' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutIsOverMaxEntry [

	| t |
	t := StThreadSafeTranscript new.
	t maxEntry: 5.
	t << 'abcdefgh'.
	self assert: t contents equals: 'fgh' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutIsOverMaxEntryAfterClear [

	| t |
	t := StThreadSafeTranscript new clear.
	t maxEntry: 5.
	t << 'abcdefgh'.
	self assert: t contents equals: 'fgh' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutIsUnderMaxEntry [

	| t |
	t := StThreadSafeTranscript new.
	t maxEntry: 5.
	t << 'toto'.
	self assert: t contents equals: 'toto' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testNextPutIsUnderMaxEntryAfterClear [

	| t |
	t := StThreadSafeTranscript new clear.
	t maxEntry: 5.
	t << 'toto'.
	self assert: t contents equals: 'toto' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testShow [

	| t |
	t := StThreadSafeTranscript new.
	t show: 'toto'.
	self assert: t contents equals: 'toto' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testShowAfterClear [

	| t |
	t := StThreadSafeTranscript new clear.
	t show: 'toto'.
	self assert: t contents equals: 'toto' 
]

{ #category : 'tests' }
StThreadSafeTranscriptTest >> testShowAndClear [

	| t |
	t := StThreadSafeTranscript new.
	t show: 'toto'.
	self assert: t contents equals: 'toto'.
	t clear.
	self assert: t contents isEmpty
]
