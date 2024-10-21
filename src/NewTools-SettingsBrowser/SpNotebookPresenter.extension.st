Extension { #name : 'SpNotebookPresenter' }

{ #category : '*NewTools-SettingsBrowser' }
SpNotebookPresenter >> addPageFirst: aPage [
	"Add a page (an instance of `SpNotebookPage`) to the notebook."

	aPage owner: self.
	pagesHolder addFirst: aPage.
	^ aPage
]

{ #category : '*NewTools-SettingsBrowser' }
SpNotebookPresenter >> hasPageNamed: aTitle [

	^ self pages anySatisfy: [ : page | 	page title = aTitle ]
]

{ #category : '*NewTools-SettingsBrowser' }
SpNotebookPresenter >> pageNamed: aTitle [

	^ self pages detect: [ : page | page title = aTitle ]
]
