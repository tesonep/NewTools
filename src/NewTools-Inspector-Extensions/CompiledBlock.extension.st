Extension { #name : 'CompiledBlock' }

{ #category : '*NewTools-Inspector-Extensions' }
CompiledBlock >> inspectionSource: aBuilder [
	<inspectorPresentationOrder: 20 title: 'Method Source'>
	
	^ (self method inspectionSource: aBuilder)
		addTextSegmentDecoration: (SpTextPresenterDecorator forHighlight
			interval: (self sourceNode sourceInterval first to: self sourceNode sourceInterval last + 1));
		yourself
]
