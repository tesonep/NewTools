Class {
	#name : 'StInspectorMockObject',
	#superclass : 'Object',
	#category : 'NewTools-Inspector-Tests',
	#package : 'NewTools-Inspector-Tests'
}

{ #category : 'inspector extensions' }
StInspectorMockObject >> inspectionMock1: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Mock 1'>

	^ aBuilder newLabel
		label: 'Test';
		yourself
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithDnuingContext: aBuilder [
	<inspectorPresentationOrder: 0 title: 'PresentationWithDNUingContext'>

	^ aBuilder newLabel
		label: 'Test';
		yourself
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithDnuingContextContext: aContext [
	
	"This selector is automatically called by concatenating Context: to an inspector presentation"
	<ignoreNotImplementedSelectors: #(iShouldNotUnderstandThis)>
	self iShouldNotUnderstandThis
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithDnuingPresentation: aBuilder [
	<inspectorPresentationOrder: 0 title: 'PresentationWithDNUingContext'>
	<ignoreNotImplementedSelectors: #(iShouldNotUnderstandThis)>
	self iShouldNotUnderstandThis
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithFailingContext: aBuilder [
	<inspectorPresentationOrder: 0 title: 'PresentationWithFailingContext'>

	^ aBuilder newLabel
		label: 'Test';
		yourself
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithFailingContextContext: aContext [
	
	"This selector is automatically called by concatenating Context: to an inspector presentation"
	
	self error
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithFailingPresentation: aBuilder [
	<inspectorPresentationOrder: 0 title: 'PresentationWithFailingPresentation'>

	self error
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithHaltingContext: aBuilder [
	<inspectorPresentationOrder: 0 title: 'PresentationWithHaltingContext'>

	^ aBuilder newLabel
		label: 'Test';
		yourself
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithHaltingContextContext: aContext [
	
	"This selector is automatically called by concatenating Context: to an inspector presentation"
	<haltOrBreakpointForTesting>
	
	self halt
]

{ #category : 'inspector extensions' }
StInspectorMockObject >> methodWithHaltingPresentation: aBuilder [
	<inspectorPresentationOrder: 0 title: 'PresentationWithHaltingContext'>
	<haltOrBreakpointForTesting>
	
	self halt
]
