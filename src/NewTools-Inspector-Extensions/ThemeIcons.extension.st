Extension { #name : 'ThemeIcons' }

{ #category : '*NewTools-Inspector-Extensions' }
ThemeIcons >> inspectionIcons: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Icons'>
	
	^ aBuilder newList
		items: (self icons associations sorted: #key ascending);
		display: [ :each | each key ];
		displayIcon: [ :each | each value ];
		yourself
]
