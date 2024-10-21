Class {
	#name : 'StSettingsNotebookPagePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'settingsBox',
		'parentNode'
	],
	#category : 'NewTools-SettingsBrowser-UI',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'UI'
}

{ #category : 'instance creation' }
StSettingsNotebookPagePresenter class >> onResults: aCollection [

	 ^ self new 
		initializeWithResults: aCollection;
		yourself

]

{ #category : 'adding' }
StSettingsNotebookPagePresenter >> add: aStSettingSectionPresenter expand: aBoolean [ 
	
	settingsBox add: aStSettingSectionPresenter expand: aBoolean 
]

{ #category : 'layout' }
StSettingsNotebookPagePresenter >> defaultLayout [

	^ SpScrollableLayout with: settingsBox
		
]

{ #category : 'initialization' }
StSettingsNotebookPagePresenter >> initializePresenters [

	settingsBox := SpBoxLayout newTopToBottom 
			spacing: 5;
			yourself
]

{ #category : 'initialization' }
StSettingsNotebookPagePresenter >> initializeWithResults: aCollection [

	aCollection do: [ : aStSettingNode |
		self add: aStSettingNode expand: true ]
]

{ #category : 'accessing' }
StSettingsNotebookPagePresenter >> pagePresenter [
	"Answer the receiver's <StSettingsPagePresenter>"

	^ self owner owner
]

{ #category : 'accessing' }
StSettingsNotebookPagePresenter >> parentNode [

	^ parentNode
]

{ #category : 'printing' }
StSettingsNotebookPagePresenter >> printOn: aStream [

	settingsBox
		ifNotNil: [ : sb | 
			super printOn: aStream.
			aStream 
				<< ' (children: ';
				<< sb children size asString;
				<< ')' ]
		ifNil: [ aStream << '(Page with no children yet)' ]
]

{ #category : 'removing' }
StSettingsNotebookPagePresenter >> removeAll [
	"Remove all presenters in the layout"

	settingsBox removeAll
]

{ #category : 'accessing - model' }
StSettingsNotebookPagePresenter >> setModelBeforeInitialization: aNode [

	parentNode := aNode
]
