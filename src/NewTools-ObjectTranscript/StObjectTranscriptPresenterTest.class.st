Class {
	#name : 'StObjectTranscriptPresenterTest',
	#superclass : 'TestCase',
	#category : 'NewTools-ObjectTranscript',
	#package : 'NewTools-ObjectTranscript'
}

{ #category : 'tests' }
StObjectTranscriptPresenterTest >> testFalseShowInspectorDoNotShowInspector [

	| st win current |
	[
	current := StObjectTranscriptPresenter showInspector.
	StObjectTranscriptPresenter showInspector: false.
	st := StObjectTranscriptPresenter new.
	win := st
		       logger: StObjectTranscriptLogger instance;
		       open.
	self assert: win initialExtent equals: 550 @ 650 ] ensure: [
		win close.
		StObjectTranscriptPresenter showInspector: current ]
]

{ #category : 'tests' }
StObjectTranscriptPresenterTest >> testTrueShowInspectorShowsInspector [
	"We wanted to show that the size of the window can dynamically be changed when the extend of the class presenter changes.
	However, in the current version of spec this is not possible. 
	A window can be resized using the resize: message but not the extent: on its presenter. 
	So a defaultPreferredExtent cannot dynamically change once the window is open."

	| st win current |

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
