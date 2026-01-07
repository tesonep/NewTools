"
It provides the following file system services to UI:

- History
- Default directory (global variable).
- Last visited directory (global variable).
- Directory opening and creation.
- Bookmarks
"
Class {
	#name : 'StFileSystemModelPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'currentDirectory',
		'history'
	],
	#classVars : [
		'Bookmarks',
		'LastVisitedDirectory'
	],
	#category : 'NewTools-FileBrowser-UI',
	#package : 'NewTools-FileBrowser',
	#tag : 'UI'
}

{ #category : 'adding' }
StFileSystemModelPresenter class >> addBookmarkNamed: aString location: aLocation iconName: aName [
	"Example: `StFileSystemModel addBookmarkNamed: 'pharo' location: FileLocator preferences / 'pharo' iconName: #git`"

	self bookmarks anyOne addBookmark: (StFileBrowserBookmark name: aString location: aLocation icon: (self iconNamed: aName))
]

{ #category : 'accessing - bookmarks' }
StFileSystemModelPresenter class >> bookmarks [

	^ Bookmarks ifNil: [
			  self initializeBookmarks.
			  Bookmarks ]
]

{ #category : 'defaults' }
StFileSystemModelPresenter class >> defaultDirectory [
	"Answer a <FileReference> with the default directory for opening the file browser and dialogs"

	^ StFileBrowserSettings defaultDirectory.
]

{ #category : 'initialization' }
StFileSystemModelPresenter class >> initializeBookmarks [
	"Set the initial <Collection> of receiver's bookmarks"

	<script>
	Bookmarks := StFileBrowserBookmark defaultBookmarks
]

{ #category : 'defaults' }
StFileSystemModelPresenter class >> lastVisitedDirectory [
	"Answer a <FileLocator> representing the last visited location"

	(LastVisitedDirectory isNotNil and: [ 
		 [ LastVisitedDirectory exists ]
			 on: ResolutionRequest
			 do: [ false ] ]) ifFalse: [ 
		LastVisitedDirectory := self defaultDirectory ].
	^ LastVisitedDirectory
]

{ #category : 'adding' }
StFileSystemModelPresenter >> addBookmark: aFileReference [ 
	"Add aFileRefefence to the global receiver's bookmarks"

	self bookmarks add: (StFileBrowserBookmark 
		name: aFileReference basename 
		location: aFileReference 
		icon: (self iconNamed: #book)).
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> bookmarks [
	"Answer the receiver's <Collection> of bookmarks, each one an instance of a subclass of <StFileBrowserAbstractBookMark>"

	^ self class bookmarks
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> bookmarks: aCollectionOfGroupBookMark [
	"Set the receiver's global bookmarks to aCollectionOfGroupBookMark"

	Bookmarks := aCollectionOfGroupBookMark ifNotNil: [ aCollectionOfGroupBookMark asOrderedCollection ]
]

{ #category : 'utilities' }
StFileSystemModelPresenter >> createDirectory [
	"Create a directory with a default name"

	^ self createDirectory: 'new-folder'
]

{ #category : 'utilities' }
StFileSystemModelPresenter >> createDirectory: initialName [
	"Create a directory named initialName <String>"

	| name path |
	
	(name := self requestUserDirectory: initialName) isEmptyOrNil 
		ifTrue: [ ^ self ].
	(path := currentDirectory / name) exists
		ifFalse: [ 
			(currentDirectory / name) ensureCreateDirectory.
			self openFolder: currentDirectory.
			^ self ].
	path isDirectory
		ifTrue: [ self application alert: 'A folder with that name already exists.' ].
	path isFile
		ifTrue: [ self application alert: 'A file with that name already exists.' ].
	self createDirectory: name
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> currentDirectory [

	^ currentDirectory
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> currentDirectory: aFileReference [

	(aFileReference exists and: [ aFileReference isDirectory ]) 
		ifFalse: [ DirectoryDoesNotExist signalWith: aFileReference ].
	currentDirectory := aFileReference.
	LastVisitedDirectory := currentDirectory
]

{ #category : 'defaults' }
StFileSystemModelPresenter >> defaultDirectory [
	^ self class defaultDirectory
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> history [
	^ history
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> history: aConfigurableHistoryIterator [ 
	history := aConfigurableHistoryIterator
]

{ #category : 'initialization' }
StFileSystemModelPresenter >> initialize [
	"Private - Initialize the receiver using stored settings"

	super initialize.
	(StFileBrowserSettings showAlwaysDefaultBookmarks and: [ self bookmarks isEmpty ])
		ifTrue: [ self class initializeBookmarks ]
]

{ #category : 'accessing' }
StFileSystemModelPresenter >> lastVisitedDirectory [
	"Answer the <FileReference> of the last visited directory"

	^ self class lastVisitedDirectory.
]

{ #category : 'utilities' }
StFileSystemModelPresenter >> openFolder: aFileReference [

	self history register: self currentDirectory.
]

{ #category : 'utilities' }
StFileSystemModelPresenter >> requestUserDirectory: initialName [
	"Open a dialog to request a directory from the user"

	| answer |
	answer := [ self
		request: 'Folder name'
		initialAnswer: initialName
		title: 'Create New Folder' ]
	on: SpCancelledInteractionError
	do: [ : ex | self inform: 'Cancelled'. nil ].
	^ answer
]

{ #category : 'initialization' }
StFileSystemModelPresenter >> resetBookmarks [ 
	"Reset the global bookmarks"

	self bookmarks: nil.
]
