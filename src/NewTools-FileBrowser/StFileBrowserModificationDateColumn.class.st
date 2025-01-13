"
I'm a column use to display the modification date of a file in a File dialog.
"
Class {
	#name : 'StFileBrowserModificationDateColumn',
	#superclass : 'StFileBrowserDateColumn',
	#category : 'NewTools-FileBrowser-Columns',
	#package : 'NewTools-FileBrowser',
	#tag : 'Columns'
}

{ #category : 'templateMethod' }
StFileBrowserModificationDateColumn class >> evaluateOn: aFileReference [

	^ [ aFileReference modificationTime ]
		  on: Error
		  do: [ nil ]
]

{ #category : 'sorting' }
StFileBrowserModificationDateColumn class >> priority [
	^ 50
]

{ #category : 'templateMethod' }
StFileBrowserModificationDateColumn class >> title [
	^ 'Date Modified'
]
