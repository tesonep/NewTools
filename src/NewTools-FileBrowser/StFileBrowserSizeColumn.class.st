"
I'm a column for display the size of the file in human readable format.
"
Class {
	#name : 'StFileBrowserSizeColumn',
	#superclass : 'StFileBrowserAbstractColumn',
	#category : 'NewTools-FileBrowser-Columns',
	#package : 'NewTools-FileBrowser',
	#tag : 'Columns'
}

{ #category : 'adding' }
StFileBrowserSizeColumn class >> addConstraintTo: aTableColumn [

	aTableColumn
		formatted: [ :e | self formatOn: e ];
		width: 70;
		beSortable
]

{ #category : 'templateMethod' }
StFileBrowserSizeColumn class >> evaluateOn: aFileReference [

	^ aFileReference isDirectory
		  ifTrue: [ 0 ]
		  ifFalse: [
			  [ aFileReference size ]
				  on: Error
				  do: [ 0 ] ]
]

{ #category : 'templateMethod' }
StFileBrowserSizeColumn class >> formatOn: aSize [

	^ aSize ifNil: [ 'N/A' ] ifNotNil: [
		  [ aSize humanReadableSISizeString ]
			  on: Error
			  do: [ 'N/A' ] ]
]

{ #category : 'sorting' }
StFileBrowserSizeColumn class >> priority [
	^ 90
]

{ #category : 'templateMethod' }
StFileBrowserSizeColumn class >> title [
	^ 'Size'
]
