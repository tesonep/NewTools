Class {
	#name : #StSpotterQuery,
	#superclass : #Object,
	#instVars : [
		'connected',
		'candidatesList',
		'processors',
		'candidateLinks',
		'searchText'
	],
	#category : #'NewTools-Spotter-Model'
}

{ #category : #'instance creation' }
StSpotterQuery class >> new [

	self error: 'Use #on:'
]

{ #category : #'instance creation' }
StSpotterQuery class >> on: aString [

	^ self basicNew 
		initializeText: aString; 
		yourself
]

{ #category : #private }
StSpotterQuery >> allCandidatesAdded: ann [
	
	ann candidateLinks ifEmpty: [ ^ self ].
	candidateLinks addAll: ann candidateLinks
]

{ #category : #accessing }
StSpotterQuery >> announcer [

	^ self candidatesList announcer
]

{ #category : #private }
StSpotterQuery >> candidateAdded: ann [

	candidateLinks add: ann candidateLink
]

{ #category : #accessing }
StSpotterQuery >> candidatesList [

	^ candidatesList
]

{ #category : #accessing }
StSpotterQuery >> candidatesList: anObject [

	candidatesList := anObject
]

{ #category : #accessing }
StSpotterQuery >> connect [

	connected := true
]

{ #category : #accessing }
StSpotterQuery >> disconnect [

	connected := false
]

{ #category : #private }
StSpotterQuery >> filteringText [
		
	^ self searchText substrings 
		detect: [ :each | each beginsWith: '#' ]
		ifFound: [ :categoryQuery | categoryQuery ]
		ifNone: [ nil ]
]

{ #category : #initialization }
StSpotterQuery >> initialize [

	super initialize.
	self initializeCandidatesList.
	candidateLinks := Set new.
	connected := false
]

{ #category : #initialization }
StSpotterQuery >> initializeCandidatesList [

	candidatesList := StSpotterCandidatesList new.
	candidatesList announcer 
		when: StSpotterCandidateAdded send: #candidateAdded: to: self;
		when: StSpotterAllCandidatesAdded send: #allCandidatesAdded: to: self.
		"when: GTSpotterAllCandidatesRemoved do: [ self deselect ];
		when: GTSpotterQueryStarted send: #propagateEvent: to: self;
		when: GTSpotterQueryEnded send: #propagateEvent: to: self."

]

{ #category : #initialization }
StSpotterQuery >> initializeText: aString [ 

	searchText := aString.
	self initialize
]

{ #category : #testing }
StSpotterQuery >> isConnected [

	^ connected
]

{ #category : #accessing }
StSpotterQuery >> links [

	^ candidateLinks
]

{ #category : #'private factory' }
StSpotterQuery >> newContextFor: aStream text: aString [

	^ GTSpotterContext new 
		step: self;
		stream: aStream;
		text: aString;
		search: aString;
		yourself
]

{ #category : #'private factory' }
StSpotterQuery >> newStreamFor: candidates [

	^ StSpotterStream new
		onAddedSelector: #addCandidate:in:;
		onRemoveSelector: #removeAllCandidatesOf:;
		receiver: candidates;
		yourself
]

{ #category : #processing }
StSpotterQuery >> process [
	| stream context |

	stream := self newStreamFor: candidatesList.
	context := self newContextFor: stream text: self searchText.
	self relevantProcessors
		do: [ :each | each filterInContext: context ]
]

{ #category : #accessing }
StSpotterQuery >> processors [

	^ processors
]

{ #category : #accessing }
StSpotterQuery >> processors: aCollection [

	processors := aCollection
]

{ #category : #private }
StSpotterQuery >> relevantProcessors [

	^ self filteringText
		ifNotNil: [ :aString | self relevantProcessorsFor: aString ]
		ifNil: [ self processors ]
]

{ #category : #private }
StSpotterQuery >> relevantProcessorsFor: aString [
		
	^ (self processors select: [ :each | each isRelevantForQuery: aString ])
]

{ #category : #accessing }
StSpotterQuery >> results [

	^ self links collect: [ :each | each value ]
]

{ #category : #accessing }
StSpotterQuery >> searchText [

	^ searchText
]
