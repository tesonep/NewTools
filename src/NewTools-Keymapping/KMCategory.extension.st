Extension { #name : 'KMCategory' }

{ #category : '*NewTools-Keymapping' }
KMCategory >> scopeName [

	^  self name
]

{ #category : '*NewTools-Keymapping' }
KMCategory >> shortcuts [

	^ (self entriesAt: #all) keymaps
]
