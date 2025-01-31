"
I am a presenter for displaying the ocurrences found by `ExpressionFinderPresenter`
"
Class {
	#name : 'StRewriterOccurrencesBrowserPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'codePresenter',
		'listPresenter'
	],
	#category : 'NewTools-RewriterTools-ChangesBrowser',
	#package : 'NewTools-RewriterTools',
	#tag : 'ChangesBrowser'
}

{ #category : 'accessing' }
StRewriterOccurrencesBrowserPresenter class >> critiques: critiques [

	^ self new
		critiques: critiques;
		yourself
]

{ #category : 'specs' }
StRewriterOccurrencesBrowserPresenter class >> defaultPreferredExtent [ 

	^ 800 @ 500
]

{ #category : 'initialization' }
StRewriterOccurrencesBrowserPresenter >> connectPresenters [

	listPresenter whenSelectedDo: [ :aReReplaceNodeCritique |
		| compiledMethod |
		compiledMethod := aReReplaceNodeCritique sourceAnchor entity.
		codePresenter
			text: compiledMethod sourceCode;
			selectionInterval: aReReplaceNodeCritique sourceAnchor interval;
			beForMethod: compiledMethod ]
]

{ #category : 'accessing' }
StRewriterOccurrencesBrowserPresenter >> critiques: critiques [

	listPresenter items: critiques
]

{ #category : 'layout' }
StRewriterOccurrencesBrowserPresenter >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		add: listPresenter;
		add: codePresenter;
		positionOfSlider: 30 percent;
		yourself
]

{ #category : 'initialization' }
StRewriterOccurrencesBrowserPresenter >> initializePresenters [

	codePresenter := self newCode.

	listPresenter := self newList.
	listPresenter
		activateOnSingleClick;
		headerTitle: 'Matches founded';
		display: [ :item | item sourceAnchor entity printString ]
]

{ #category : 'initialization' }
StRewriterOccurrencesBrowserPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter askOkToClose: false
]

{ #category : 'initialization' }
StRewriterOccurrencesBrowserPresenter >> windowTitle [ 

	^ 'Occurrences matches'
]
