Class {
	#name : 'StFileBrowserDateColumn',
	#superclass : 'StFileBrowserAbstractColumn',
	#category : 'NewTools-FileBrowser-Columns',
	#package : 'NewTools-FileBrowser',
	#tag : 'Columns'
}

{ #category : 'adding' }
StFileBrowserDateColumn class >> addConstraintTo: aTableColumn [

	aTableColumn
		width: 150;
		formatted: [ :v | self formatOn: v ];
		beSortable
]

{ #category : 'templateMethod' }
StFileBrowserDateColumn class >> formatOn: aValue [

	aValue ifNil: [ ^ 'N/A' ].
	^ '{1} {2} {3} {4}' format: {
			  aValue dayOfMonth asString.
			  aValue monthAbbreviation.
			  aValue year asString.
			  (aValue asTime print24 first: 5) }
]

{ #category : 'testing' }
StFileBrowserDateColumn class >> isAbstract [

	^ self == StFileBrowserDateColumn
]
