"
A WindowConfiguration is a description of the window on the screen (extent, position, kind, strategy)
"
Class {
	#name : 'CavAbstractWindowPlaceHolder',
	#superclass : 'Object',
	#instVars : [
		'extent',
		'kind',
		'position',
		'strategy',
		'count',
		'visualPlaceHolder'
	],
	#category : 'NewTools-Window-Profiles',
	#package : 'NewTools-Window-Profiles'
}

{ #category : 'as yet unclassified' }
CavAbstractWindowPlaceHolder class >> exampleTranscript [

	^ self new 
		extent: 400@666;
		position: 180.0@106.0;
		kind: #Transcript;
		yourself


	
]

{ #category : 'initialization' }
CavAbstractWindowPlaceHolder >> configureStrategy [


	strategy placeHolder: self

	
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> count [
	^ count
]

{ #category : 'api' }
CavAbstractWindowPlaceHolder >> display [

	visualPlaceHolder := CavVisualPlaceHolder new
		                     extent: extent;
		                     position: position;
		                     addMorph: (TextMorph new
				                      contents: kind printString;
				                      position: position x
					                      +
						                      (extent x
						                       -
							                       (TextMorph new contents:
									                        kind printString) width / 2)
					                      @ position y + 3).
					visualPlaceHolder placeHolder: self.
	visualPlaceHolder openInWorld
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> extent [
	^ extent
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> extent: aPoint [ 
	extent := aPoint
]

{ #category : 'initialization' }
CavAbstractWindowPlaceHolder >> increment [ 
	
	count := count + 1
]

{ #category : 'initialization' }
CavAbstractWindowPlaceHolder >> initialize [

	super initialize. 
	strategy := CavStackingStrategy new.
	strategy placeHolder: self.
	"count is counting the number of opened window.
	not really nice but let us get started."
	kind := 'empty'.
	count := 1.	

]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> kind [

	^ kind
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> kind: anObject [

	kind := anObject
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> position [
	^ position
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> position: aPoint [ 
	position := aPoint
]

{ #category : 'printing' }
CavAbstractWindowPlaceHolder >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '(' , kind printString , ' ' , (self strategy
			 ifNotNil: [ :s | s class name ]
			 ifNil: [ ' nil strategy' ]) , ')'
]

{ #category : 'printing' }
CavAbstractWindowPlaceHolder >> resetCount [ 
	 
	count := 0.
]

{ #category : 'initialization' }
CavAbstractWindowPlaceHolder >> setDefaultStrategy [

	
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> strategy [ 

	^ strategy
]

{ #category : 'accessing' }
CavAbstractWindowPlaceHolder >> strategy: aStrategy [

	strategy := aStrategy.
	aStrategy placeHolder: self.
]
