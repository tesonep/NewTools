"
A model to process queries (to be used with StSpotter).
The main method is `StSpotterModel>>processSearch:on:` (is the entry point to any query).

To process searches the spotter model will use a worker pool to schedule a `StSpotterQuery`, which is the actual responsible of processing it.
"
Class {
	#name : 'StSpotterModel',
	#superclass : 'Object',
	#instVars : [
		'steps',
		'searchUpdatedAction',
		'amountChangedAction',
		'mutex',
		'queryStartedAction',
		'queryEndedAction',
		'noResultsAction',
		'scheduler',
		'pendingQuery',
		'queryRequestTime',
		'processors'
	],
	#category : 'NewTools-Spotter-Model',
	#package : 'NewTools-Spotter',
	#tag : 'Model'
}

{ #category : 'instance creation' }
StSpotterModel class >> delayBeforeQuery [

	^ 500 milliSeconds 
]

{ #category : 'instance creation' }
StSpotterModel class >> newOrigin: anObject [ 

	^ self basicNew 
		initializeOrigin: anObject;
		yourself
]

{ #category : 'accessing' }
StSpotterModel >> activeProcessors [

	^ self activeStep processors
]

{ #category : 'accessing' }
StSpotterModel >> activeStep [

	^ self steps last
]

{ #category : 'private' }
StSpotterModel >> addStep: aStep [

	steps ifNil: [ steps := OrderedCollection new ].
	steps addLast: aStep
]

{ #category : 'private - announcing' }
StSpotterModel >> announceAllCandidatesAdded: ann [

	searchUpdatedAction ifNil: [ ^ self ].

	ann candidateLinks 
		do: [ :each | searchUpdatedAction value: each ]
]

{ #category : 'private - announcing' }
StSpotterModel >> announceAmountChanged: ann [

	amountChangedAction ifNil: [ ^ self ].
	amountChangedAction 
		value: ann category 
		value: ann amount
]

{ #category : 'private - announcing' }
StSpotterModel >> announceCandidateAdded: ann [

	searchUpdatedAction ifNil: [ ^ self ].
	searchUpdatedAction value: ann candidateLink
]

{ #category : 'private - announcing' }
StSpotterModel >> announceNoResults [

	noResultsAction ifNil: [ ^ self ].
	noResultsAction value
]

{ #category : 'private - announcing' }
StSpotterModel >> announceQueryEnded: ann [

	queryEndedAction ifNil: [ ^ self ].
	queryEndedAction value
]

{ #category : 'private - announcing' }
StSpotterModel >> announceQueryStarted: ann [

	queryStartedAction ifNil: [ ^ self ].
	queryStartedAction value
]

{ #category : 'private' }
StSpotterModel >> defaultProcessors [

	^ (StSpotterProcessor allEnabledSubclasses 
		collect: [ :each | each new ])
		sort: #order ascending 
]

{ #category : 'private - queries' }
StSpotterModel >> doProcessSearch: aString on: spotter [

	pendingQuery := StSpotterQuery 
		newSearch: aString 
		on: spotter.
	
	self pushQuery: pendingQuery
]

{ #category : 'initialization' }
StSpotterModel >> initialize [

	super initialize.
	
	scheduler := TKTWorkerPool new.
	scheduler poolMaxSize: 5.
	scheduler start.
	
	mutex := Mutex new
]

{ #category : 'initialization' }
StSpotterModel >> initializeOrigin: anObject [
	
	self initialize.
	self addStep: (self newStep
		origin: anObject;
		yourself)
]

{ #category : 'testing' }
StSpotterModel >> isFree [ 

  ^ scheduler isFree
]

{ #category : 'testing' }
StSpotterModel >> isNested [

	^ self steps size > 1
]

{ #category : 'accessing' }
StSpotterModel >> lastSearchText [

	^ self activeStep lastSearchText
]

{ #category : 'accessing' }
StSpotterModel >> links [

	^ self activeStep links
]

{ #category : 'private - factory' }
StSpotterModel >> newDefaultStep [

	^ self newStep
		origin: self;
		yourself
]

{ #category : 'private - factory' }
StSpotterModel >> newStep [

	^ StSpotterStep on: self
]

{ #category : 'accessing' }
StSpotterModel >> popStep [
	| lastQuery |

	"Do not pop first"
	self steps size > 1 ifFalse: [ ^ self ]. 

	lastQuery := self activeStep activeQuery.
	self activeStep deactivate.
	self steps removeLast.
	self activeStep activate
]

{ #category : 'private - queries' }
StSpotterModel >> processSearch: aString on: spotter [

	queryRequestTime := Time now.
	
	[ self class delayBeforeQuery wait. 
		((self class delayBeforeQuery + queryRequestTime) <= Time now)
			ifTrue: [ self doProcessSearch: aString on: spotter ] ] fork.	
]

{ #category : 'accessing' }
StSpotterModel >> processors [

	^ processors ifNil: [ self defaultProcessors ]
]

{ #category : 'accessing' }
StSpotterModel >> processors: aCollection [

	processors := aCollection
]

{ #category : 'accessing - query' }
StSpotterModel >> pushQuery: aQuery [

	self schedule: [ 
		mutex critical: [ 
			self activeStep pushQuery: aQuery ] ]
]

{ #category : 'private - queries' }
StSpotterModel >> pushStepForProcessor: aProcessor [
	| step allCandidates processorLink |

	self activeStep deactivate.

	step := self newStep.
	processorLink := aProcessor asStSpotterProcessorLink.
	allCandidates := aProcessor allFilteredCandidates collect: [ :each | 
		each asStSpotterCandidateLink renderingProcessor: processorLink ].
	step origin: allCandidates.
	self addStep: step
]

{ #category : 'accessing' }
StSpotterModel >> results [

	^ self activeStep results
]

{ #category : 'accessing' }
StSpotterModel >> schedule: aBlock [

	scheduler purge.
	scheduler schedule: [
		aBlock 
			on: Error 
			fork: [ :e | e pass ] ]
]

{ #category : 'private' }
StSpotterModel >> scheduler [

	^ scheduler
]

{ #category : 'accessing' }
StSpotterModel >> stSpotterProcessorsFor: aStep [

	self processors 
		do: [ :each | aStep addProcessor: each ]
]

{ #category : 'accessing - query' }
StSpotterModel >> startProcessingOn: spotter [

	self doProcessSearch: '' on: spotter. 

]

{ #category : 'private' }
StSpotterModel >> steps [

	^ steps ifNil: [ 
		self addStep: self newDefaultStep.
		steps ]
]

{ #category : 'accessing - query' }
StSpotterModel >> stopProcessing [

	self activeStep deactivate.
	scheduler stop
	
]

{ #category : 'events' }
StSpotterModel >> whenAmountChangedDo: aBlock [

	amountChangedAction := aBlock
]

{ #category : 'events' }
StSpotterModel >> whenNoResultsDo: aBlock [

	noResultsAction := aBlock
]

{ #category : 'events' }
StSpotterModel >> whenQueryEndedDo: aBlock [

	queryEndedAction := aBlock
]

{ #category : 'events' }
StSpotterModel >> whenQueryStartedDo: aBlock [

	queryStartedAction := aBlock
]

{ #category : 'events' }
StSpotterModel >> whenSearchUpdatedDo: aBlock [

	searchUpdatedAction := aBlock
]
