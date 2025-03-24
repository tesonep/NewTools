"
I'm a circular logger that works with `StObjectTranscriptPresenter` instances.
II get a direct reference to my UI so that I can ask them to refresh them.
I do not use announcements for this by design!
May be this aspect can be changed in the future. 


Here is a typical global usage example

```
| cb |
StObjectTranscriptLogger start.
cb := StObjectTranscriptPresenter new.
cb logger: StObjectTranscriptLogger instance.
'this is a message only interesting from the logger domain' emit.
cb open.
```

"
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
	clients do: [ :each | each refresh ]
]

{ #category : 'initialization' }
StObjectTranscriptLogger >> removeAsClient: anObject [

	clients remove: anObject ifAbsent: [ ]
]

{ #category : 'initialization' }
StObjectTranscriptLogger >> resetClients [

 	clients := OrderedDictionary new
]
