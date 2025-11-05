Extension { #name : 'Symbol' }

{ #category : '*NewTools-Inspector-Extensions' }
Symbol >> previewString [

	^ self stDisplayString
]

{ #category : '*NewTools-Inspector-Extensions' }
Symbol >> stDisplayString [

	^ (self truncateWithElipsisTo: 1000) printString
]
