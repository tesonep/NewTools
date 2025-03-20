Extension { #name : 'OCIRMethod' }

{ #category : '*NewTools-Inspector-Extensions' }
IRMethod >> inpectionIr: aBuilder [
	<inspectorPresentationOrder: 40 title: 'Symbolic'>

	^ aBuilder newText 
		text: (self ir longPrintString trimmed);
		yourself
]
