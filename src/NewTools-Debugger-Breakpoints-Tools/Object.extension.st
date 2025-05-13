Extension { #name : 'Object' }

{ #category : '*NewTools-Debugger-Breakpoints-Tools' }
Object >> inspectionBreakpoints: aBuilder [
	<inspectorPresentationOrder: 998 title: 'Breakpoints'>

	^ aBuilder instantiate: StObjectBreakpointInspection on: self
]

{ #category : '*NewTools-Debugger-Breakpoints-Tools' }
Object >> inspectionBreakpointsContext: aContext [

	aContext withoutEvaluator
]
