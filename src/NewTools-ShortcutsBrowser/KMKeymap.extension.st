Extension { #name : 'KMKeymap' }

{ #category : '*NewTools-ShortcutsBrowser' }
KMKeymap >> scope [

	^ KMRepository default categories 
		detect: [ : cat | cat keymaps includes: self ]
]

{ #category : '*NewTools-ShortcutsBrowser' }
KMKeymap >> scopeName [

	^  self scope scopeName
]
