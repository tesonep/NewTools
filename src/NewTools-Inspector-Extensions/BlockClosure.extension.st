Extension { #name : 'BlockClosure' }

{ #category : '*NewTools-Inspector-Extensions' }
BlockClosure >> inpectionIr: aBuilder [
	<inspectorPresentationOrder: 35 title: 'IR'>

	^ self method ir inpectionIr: aBuilder
]

{ #category : '*NewTools-Inspector-Extensions' }
BlockClosure >> inspectionAST: aBuilder [
	<inspectorPresentationOrder: 35 title: 'AST'>

	^ self sourceNode inspectionAST: aBuilder
]

{ #category : '*NewTools-Inspector-Extensions' }
BlockClosure >> inspectionSource: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Method Source'>

	^ self sourceNode inspectionSource: aBuilder
]
