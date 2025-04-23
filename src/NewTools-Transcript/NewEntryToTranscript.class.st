"
I'm a little announcement to communicate with my representents. 
"
Class {
	#name : 'NewEntryToTranscript',
	#superclass : 'Announcement',
	#instVars : [
		'entry'
	],
	#category : 'NewTools-Transcript',
	#package : 'NewTools-Transcript'
}

{ #category : 'accessing' }
NewEntryToTranscript >> entry [ 
	
	^ entry
]

{ #category : 'accessing' }
NewEntryToTranscript >> entry: aString [

	entry := aString
]
