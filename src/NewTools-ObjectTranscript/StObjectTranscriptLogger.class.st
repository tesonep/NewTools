Class {
	#name : 'StObjectTranscriptLogger',
	#superclass : 'CircularMemoryLogger',
	#instVars : [
		'clients'
	],
	#category : 'NewTools-ObjectTranscript',
	#package : 'NewTools-ObjectTranscript'
}

{ #category : 'initialization' }
StObjectTranscriptLogger >> addAsClient: anObject [

	clients add: anObject
]

{ #category : 'initialization' }
StObjectTranscriptLogger >> initialize [ 
	
	super initialize.
	clients := OrderedCollection new
]

{ #category : 'utilities' }
StObjectTranscriptLogger >> nextPut: aSignal [

	super nextPut: aSignal.
	clients do: [ :each | each update ]
]

{ #category : 'initialization' }
StObjectTranscriptLogger >> removeAsClient: anObject [

	clients remove: anObject ifAbsent: [ ]
]

{ #category : 'initialization' }
StObjectTranscriptLogger >> resetClients [

 	clients := OrderedDictionary new
]
