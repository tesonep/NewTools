"
I'm a new transcript. 

My existence is to be able to remove the global variable Transcript from the system dictionary.
I'm raising an announcement so that my visual representant can update themselves.

I'm based on a circular list.

"
Class {
	#name : 'StThreadSafeTranscript',
	#superclass : 'Model',
	#instVars : [
		'mutex',
		'recordings',
		'index',
		'maxEntry',
		'worker'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : 'NewTools-Transcript',
	#package : 'NewTools-Transcript'
}

{ #category : 'private - testing' }
StThreadSafeTranscript class >> createTestingInstance [
"This method SHOULD NOT be used. It is only used for testing, and doing so would break the singleton."

	^ super new.
]

{ #category : 'declare' }
StThreadSafeTranscript class >> install [

	self installThreadSafeAsTranscript
]

{ #category : 'declare' }
StThreadSafeTranscript class >> installThreadSafeAsTranscript [
	<script>

	Smalltalk globals at: #Transcript put: self uniqueInstance
]

{ #category : 'instance creation' }
StThreadSafeTranscript class >> new [

	self error: 'You cannot create instances of this class. Use Singleton instead'
]

{ #category : 'declare' }
StThreadSafeTranscript class >> reset [
	<script>

	UniqueInstance := nil
]

{ #category : 'icons' }
StThreadSafeTranscript class >> taskbarIconName [
	"Answer the icon for the receiver in a task bar."

	^#transcript
]

{ #category : 'instance creation' }
StThreadSafeTranscript class >> uniqueInstance [
	
	<script>
	^ UniqueInstance ifNil: [
		UniqueInstance := super new ]
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> << anObject [
	"Write anObject to the receiver, dispatching using #putOn:
	This is a shortcut for both nextPut: and nextPutAll: since anObject can be both
	the element type of the receiver as well as a collection of those elements.
	No further conversions of anObject are applied.
	Return self to accomodate chaining."

 	anObject putOn: self
]

{ #category : 'private - actions' }
StThreadSafeTranscript >> addEntry: aString [

	index := index >= maxEntry
		ifTrue: [ 1 ]
		ifFalse: [ index + 1 ].
	recordings at: index put: aString.
	self announce

	
]

{ #category : 'initialization' }
StThreadSafeTranscript >> allocateRecodings: size [

	recordings := Array new: size
]

{ #category : 'private - actions' }
StThreadSafeTranscript >> announce [
	
	self worker schedule: [ SystemAnnouncer uniqueInstance announce: NewEntryToTranscript new ]
]

{ #category : 'streaming' }
StThreadSafeTranscript >> clear [

	mutex critical: [
		self allocateRecodings: maxEntry.
		index := 0.
		SystemAnnouncer uniqueInstance announce: NewEntryToTranscript new  ]
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> close [
	"Close the receiver, indicating it is not longer needed"
]

{ #category : 'protected low level' }
StThreadSafeTranscript >> contents [ 
	"probably super inefficient again... "
	
	^ String streamContents: [ :s |
		1 to: index do: [ :i | s << (recordings at: i ) asString ] ] 
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> cr [
	"Output a cr on the receiver"

	self nextPut: Character cr
]

{ #category : 'private - actions' }
StThreadSafeTranscript >> critical: block [
	"Execute block making sure only one thread accesses the receiver"
	
	^ mutex critical: block
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> endEntry [
	"Show the currently buffered output"
]

{ #category : 'streaming' }
StThreadSafeTranscript >> flush [
	
	
]

{ #category : 'testing' }
StThreadSafeTranscript >> hasBindingOf: aString [
	^ false
]

{ #category : 'initialization' }
StThreadSafeTranscript >> initialize [

	super initialize.
	mutex := Mutex new.
	maxEntry := 1000.
	index := 0.
	self allocateRecodings: maxEntry
]

{ #category : 'initialization' }
StThreadSafeTranscript >> maxEntry: aNumber [

	maxEntry := aNumber.
	self allocateRecodings: maxEntry.
]

{ #category : 'private - events' }
StThreadSafeTranscript >> nextPut: aCharacter [

	mutex critical: [
		self addEntry: aCharacter asString ].
	^ aCharacter

]

{ #category : 'private - events' }
StThreadSafeTranscript >> nextPutAll: value [
	"Ineffient way...."

	self critical: [ self addEntry: value asString ].
	^ value
]

{ #category : 'ui' }
StThreadSafeTranscript >> open [ 

	^ StTranscriptPresenter openOn: self
]

{ #category : 'streaming' }
StThreadSafeTranscript >> reset [

	self clear
]

{ #category : 'updating' }
StThreadSafeTranscript >> shoutAboutToStyle: aPluggableShoutMorphOrView [
	^ false
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> show: anObject [
	"Output anObject asString on the receiver and show the output"

	self critical: [ self << anObject ]
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> space [
	"Output a space on the receiver"

	self nextPut: Character space
]

{ #category : 'private - events' }
StThreadSafeTranscript >> stepGlobal [ 

	" do nothing this is just to be compatible with the old transcript
	Not having this method while morphic is calling you is a bad idea and you are dead.
	
	"
]

{ #category : 'stop conditions' }
StThreadSafeTranscript >> tab [
	"Output a tab on the receiver"

	self nextPut: Character tab
]

{ #category : 'accessing' }
StThreadSafeTranscript >> worker [ 

	^ worker ifNil: [ worker := TKTWorker new start ] 
]
