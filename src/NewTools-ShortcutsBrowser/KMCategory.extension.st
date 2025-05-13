Extension { #name : 'KMCategory' }

{ #category : '*NewTools-ShortcutsBrowser' }
KMCategory >> scopeName [

	^  self name
]

{ #category : '*NewTools-ShortcutsBrowser' }
KMCategory >> shortcuts [

	^ (self entriesAt: #all) keymaps asOrderedCollection
]
