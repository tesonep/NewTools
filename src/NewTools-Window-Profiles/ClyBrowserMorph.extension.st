Extension { #name : 'ClyBrowserMorph' }

{ #category : '*NewTools-Window-Profiles' }
ClyBrowserMorph >> open [

	| window |
	self ensureInitialState.
	window := self openInWindow.
	window model: self.
	self updateWindowTitle.
	window minimumExtent: (650 @ 500.0) scaledByDisplayScaleFactor.
	CavroisWindowManager current placePresenter: window
]
