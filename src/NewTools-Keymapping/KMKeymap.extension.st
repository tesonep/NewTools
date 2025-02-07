Extension { #name : 'KMKeymap' }

{ #category : '*NewTools-Keymapping' }
KMKeymap >> scope [

	^ KMRepository default categories 
		detect: [ : cat | cat keymaps includes: self ]
]

{ #category : '*NewTools-Keymapping' }
KMKeymap >> scopeName [

	^  self scope scopeName
]
