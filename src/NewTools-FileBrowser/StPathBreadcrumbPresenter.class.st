"
I provide a windowPathEditor 

API

- `currentDirectory:  aFileReference` see example class side 
- `presenterUI: theUIUsingThisPresenter` you have to send this message see the following example:

```smalltalk
		 MyUi >> initializePresenters
			...
			maVar := self instantiate: StPathBreadcrumbPresenter.
			maVar presenterUI: self.
			...
```
			
UI using this widget have to define openOn: aFileReference

"
Class {
	#name : 'StPathBreadcrumbPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'textInput',
		'editButton',
		'path',
		'isInEditMode'
	],
	#category : 'NewTools-FileBrowser-UI',
	#package : 'NewTools-FileBrowser',
	#tag : 'UI'
}

{ #category : 'examples' }
StPathBreadcrumbPresenter class >> example [
	<example>
	^ self new
		currentDirectory: FileLocator imageDirectory;
		open
]

{ #category : 'accessing' }
StPathBreadcrumbPresenter >> currentDirectory [
	^ self owner ifNotNil: #currentDirectory
]

{ #category : 'accessing' }
StPathBreadcrumbPresenter >> currentDirectory: aFileReference [

	textInput text: aFileReference fullName.
	path file: aFileReference.
	self needRebuild: false.
	self build
]

{ #category : 'layout' }
StPathBreadcrumbPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  vAlignCenter;
		  add: path;
		  add: editButton
		  expand: false
		  fill: false
		  padding: 0;
		  yourself
]

{ #category : 'layout' }
StPathBreadcrumbPresenter >> editablelayout [

	^ SpBoxLayout newLeftToRight
		  add: textInput;
		  add: editButton
		  expand: false
		  fill: false
		  padding: 0;
		  yourself
]

{ #category : 'accessing' }
StPathBreadcrumbPresenter >> entityText [
	^ textInput
]

{ #category : 'initialization' }
StPathBreadcrumbPresenter >> initializePresenters [

	textInput := self newTextInput.
	path := self instantiate: StPathPresenter.
	editButton := self newButton.

	isInEditMode := false.

	self path action: [ :fileReference | self updatePathSelection: fileReference ].

	self entityText whenSubmitDo: [ :newText | self pathTextChangedTo: newText ].

	textInput placeholder: 'path/to/file'.

	editButton
		addStyle: 'small';
		icon: (self application iconNamed: #edit);
		help: 'Edit the path to the current folder';
		action: [
			self needRebuild: false.

			isInEditMode
				ifTrue: [ self pathTextChangedTo: self entityText text ]
				ifFalse: [
					self layout: self editablelayout.
					isInEditMode := isInEditMode not ] ]
]

{ #category : 'accessing' }
StPathBreadcrumbPresenter >> path [
	^ path
]

{ #category : 'callbacks' }
StPathBreadcrumbPresenter >> pathTextChangedTo: aStringOrText [

	| fileReference |

	fileReference := aStringOrText asString asFileReference.
	(fileReference exists and: [ fileReference isDirectory ])
		ifTrue: [ self updatePathSelection: fileReference ]
		ifFalse: [ self inform: 'You have to input an existing path to a directory' ].
	isInEditMode := false.
	self layout: self defaultLayout.

]

{ #category : 'callbacks' }
StPathBreadcrumbPresenter >> updatePathSelection: fileReference [
	"Private - Receiver's path has changed, update owner's presenters. Prevent recursive updating because path selection could be triggered from file table or file tree presenters"

	self owner model currentDirectory = fileReference ifFalse: [
		self owner openFolder: fileReference ].

	fileReference isDirectory ifFalse: [
		self owner nameText: fileReference basename ]
]
