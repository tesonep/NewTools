Extension { #name : 'CompiledMethod' }

{ #category : '*NewTools-Inspector-Extensions' }
CompiledMethod >> inspectionPragmas: aBuilder [
	<inspectorPresentationOrder: 50 title: 'Pragmas'> 

	^ aBuilder newList
		items: self pragmas;
		display: [ :aPragma | aPragma printString ];
		yourself
]

{ #category : '*NewTools-Inspector-Extensions' }
CompiledMethod >> inspectionPragmasContext: aContext [ 
	
	aContext active: self hasPragmas
]
