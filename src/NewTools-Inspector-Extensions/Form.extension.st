Extension { #name : 'Form' }

{ #category : '*NewTools-Inspector-Extensions' }
Form >> inspectionForm: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Form'>
	
	^ aBuilder newMorph 
		morph: self asMorph;
		yourself
]
