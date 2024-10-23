Extension { #name : 'SpNotebookPresenter' }

{ #category : '*NewTools-SettingsBrowser' }
SpNotebookPresenter >> hasPageNamed: aTitle [

	^ self pages anySatisfy: [ : page | 	page title = aTitle ]
]

{ #category : '*NewTools-SettingsBrowser' }
SpNotebookPresenter >> hasPages [

	^ self pages isNotEmpty
]

{ #category : '*NewTools-SettingsBrowser' }
SpNotebookPresenter >> pageNamed: aTitle [

	^ self pages detect: [ : page | page title = aTitle ]
]
