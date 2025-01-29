Extension { #name : 'Text' }

{ #category : '*NewTools-Inspector-Extensions' }
Text >> inspectionText: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Text'>

	^ aBuilder newMorph
		morph: (RubScrolledTextMorph new
			setText: self;
			in: [ :this | this textArea
				readOnly: true;
				font: StandardFonts codeFont ];
			yourself);
		yourself
]
