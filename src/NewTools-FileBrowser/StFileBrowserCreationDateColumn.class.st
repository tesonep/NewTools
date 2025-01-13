"
I'm a column use to display the creation date of a file in a File dialog.
"
Class {
	#name : 'StFileBrowserCreationDateColumn',
	#superclass : 'StFileBrowserDateColumn',
	#category : 'NewTools-FileBrowser-Columns',
	#package : 'NewTools-FileBrowser',
	#tag : 'Columns'
}

{ #category : 'templateMethod' }
StFileBrowserCreationDateColumn class >> evaluateOn: aFileReference [

	^ aFileReference creationTime
]

{ #category : 'sorting' }
StFileBrowserCreationDateColumn class >> priority [
	^ 60
]

{ #category : 'templateMethod' }
StFileBrowserCreationDateColumn class >> title [
	^ 'Date Created'
]
