Extension { #name : 'Announcer' }

{ #category : '*NewTools-Inspector-Extensions' }
Announcer >> hasSubscriptions [
	
	^ self numberOfSubscriptions isZero not
]

{ #category : '*NewTools-Inspector-Extensions' }
Announcer >> inspectionSubscriptions: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Subscriptions'>

	^ registry inspectionSubscriptions: aBuilder
]

{ #category : '*NewTools-Inspector-Extensions' }
Announcer >> inspectionSubscriptionsContext: aContext [ 
	
	aContext active: self hasSubscriptions
]
