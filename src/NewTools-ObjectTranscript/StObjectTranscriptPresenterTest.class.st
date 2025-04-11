Class {
	#name : 'StObjectTranscriptPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'NewTools-ObjectTranscript',
	#package : 'NewTools-ObjectTranscript'
}

{ #category : 'tests' }
StObjectTranscriptPresenterTest >> setUp [ 

presenter := StObjectTranscriptPresenter new.
presenter logger: StObjectTranscriptLogger instance.
]

{ #category : 'tests' }
StObjectTranscriptPresenterTest >> testSmoke [

	| window |
	[ self shouldnt: [ window := presenter open ] raise: Error ] ensure: [ window close ].

	[ self shouldnt: [ window := presenter openDialog ] raise: Error ] ensure: [ window close ].
]

{ #category : 'tests' }
StObjectTranscriptPresenterTest >> testTrueShowInspectorShowsInspector [
	"We wanted to show that the size of the window can dynamically be changed when the extend of the class presenter changes.
	However, in the current version of spec this is not possible. 
	A window can be resized using the resize: message but not the extent: on its presenter. 
	So a defaultPreferredExtent cannot dynamically change once the window is open."
	| st win current |

	"With the new changes that makes it so the window remembers its last state, this test will fail if the user has ever resized it."
	self skip.
	
	[
	current := StObjectTranscriptPresenter showInspector.
	"StObjectTranscriptPresenter resetRememberedResizeExtent."
	StObjectTranscriptPresenter showInspector: true.
	st := StObjectTranscriptPresenter new.
	st logger: StObjectTranscriptLogger instance.
	win := st asWindow.
	win resizable: false.
	win open.
	
	self assert: win initialExtent equals: 550 @ 850 ] ensure: [
		win close.
		StObjectTranscriptPresenter showInspector: current ]
]
