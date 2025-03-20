"
I'm a column use to display the last access date of a file in a File dialog.
"
Class {
	#name : 'StFileBrowserLastOpenDateColumn',
	#superclass : 'StFileBrowserDateColumn',
	#category : 'NewTools-FileBrowser-Columns',
	#package : 'NewTools-FileBrowser',
	#tag : 'Columns'
}

{ #category : 'templateMethod' }
StFileBrowserLastOpenDateColumn class >> evaluateOn: aFileReference [

	^ aFileReference accessTime
]

{ #category : 'sorting' }
StFileBrowserLastOpenDateColumn class >> priority [
	^ 70
]

{ #category : 'templateMethod' }
StFileBrowserLastOpenDateColumn class >> title [
	^ 'Date Last Opened'
]
