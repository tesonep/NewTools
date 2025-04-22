"
I a simple presenter that displays the contents of newThreadSafeTranscript instances.
I listen to the NewEntryToTranscript announcement to refresh my contents.


"
Class {
	#name : 'StTranscriptPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'text',
		'transcript',
		'toolbar'
	],
	#category : 'NewTools-Transcript',
	#package : 'NewTools-Transcript'
}

{ #category : 'accessing' }
StTranscriptPresenter class >> defaultPreferredExtent [

	^ (447 @ 300) scaledByDisplayScaleFactor
]

{ #category : 'accessing' }
StTranscriptPresenter class >> example [
	"this example shows that we can use a different instance than the singleton."
	<script>
	
	| t tr |
	t := self new. 
	tr := StThreadSafeTranscript new.
	tr show: 'Hello Pharo I''m a new textual transcript'.
	t transcript: tr.
	t open. 
]

{ #category : 'accessing' }
StTranscriptPresenter class >> exampleDefault [
	"this example shows that we can use a different instance than the singleton."
	<script>
	
	self new open
]

{ #category : 'accessing' }
StTranscriptPresenter class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'Transcript')
		action: [ (Smalltalk tools toolNamed: #transcript) new open ];
		order: 2;
		parent: #InputOutput;
		help: 'Transcript';
		keyText: 'o, t';
		help: 'Window on the new Transcript output stream, which is useful for writing log messages.';
		iconName: #transcript
	
]

{ #category : 'instance creation' }
StTranscriptPresenter class >> open [

	<script>
	^ self new open
]

{ #category : 'instance creation' }
StTranscriptPresenter class >> openOn: aTranscript [

	<script>
	^ self new transcript: aTranscript; open
]

{ #category : 'tools registry' }
StTranscriptPresenter class >> registerToolsOn: aRegistry [
	"Smalltalk tools register: self as: #transcript"

	aRegistry register: self as: #transcript
]

{ #category : 'initialization' }
StTranscriptPresenter >> initialize [ 

	super initialize.
	self registerToAnnouncer. 
	transcript := StThreadSafeTranscript uniqueInstance
]

{ #category : 'initialization' }
StTranscriptPresenter >> initializePresenters [ 


	text := self newText.
	text beEditable.
	toolbar := self newToolbar.
	self initializeToolBar
	
	
]

{ #category : 'initialization' }
StTranscriptPresenter >> initializeToolBar [

	toolbar := self newToolbar 
  		addStyle: 'stToolbar';
  		displayMode: self application toolbarDisplayMode;
  		yourself.
	
	toolbar
		add: (toolbar newToolbarButton 
			label: 'Clear';
			icon: (self application iconNamed: #changeRemove );
			help: 'Clears the transcriptor';
			action: [ transcript clear ]);
		add: (toolbar newToolbarButton 
			label: 'Fetch';
			icon: (self application iconNamed: #down );
			help: 'Fetches the old recordings of the transcript';
			action: [ transcript fetchOld ])
]

{ #category : 'initialization' }
StTranscriptPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenOpenedDo: [ self updateNewEntry ];
		whenClosedDo: [ self unregister ]
]

{ #category : 'layout' }
StTranscriptPresenter >> layout [ 

	^ SpBoxLayout newLeftToRight 
			add: toolbar;
			add: text;
			yourself
]

{ #category : 'registration' }
StTranscriptPresenter >> registerToAnnouncer [

	
	SystemAnnouncer uniqueInstance
		when: NewEntryToTranscript
		send: #updateNewEntry
		to: self
]

{ #category : 'accessing' }
StTranscriptPresenter >> text [

	^ text
]

{ #category : 'accessing' }
StTranscriptPresenter >> transcript: aTranscript [

	transcript := aTranscript.
	self updateNewEntry
]

{ #category : 'registration' }
StTranscriptPresenter >> unregister [

	^ SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : 'accessing' }
StTranscriptPresenter >> updateNewEntry [

	text text: transcript contents
	
]

{ #category : 'accessing' }
StTranscriptPresenter >> windowTitle [

	^ 'Transcript'
]
