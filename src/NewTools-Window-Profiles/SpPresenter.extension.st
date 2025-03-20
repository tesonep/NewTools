Extension { #name : 'SpPresenter' }

{ #category : '*NewTools-Window-Profiles' }
SpPresenter >> hasInitialPosition [

	^ self properties keys includes: #position
]

{ #category : '*NewTools-Window-Profiles' }
SpPresenter >> initialPosition [

	^ self position
]

{ #category : '*NewTools-Window-Profiles' }
SpPresenter >> initializeWindow: aWindowPresenter [
	"override this to set window values before opening. 
	 You may want to add a menu, a toolbar or a statusbar"

	"IMPORTANT: Please ovirride this method and set yourself the informations you want in your window.
	The content of this method is here to help the transition between Spec 1 and 2.
	In the next Spec version the content of this method will be removed and it will do nothing by default because the goal is to remove the management of all of those informations from Composable to put them in WindowPresenter."

	self hasInitialPosition ifTrue: [ aWindowPresenter initialPosition: self initialPosition ].
	
	"We should check if the lines above are needed and else we should push them in Spec Core."
	
	aWindowPresenter
		title: self windowTitle;
		initialExtent: self class preferredExtent;
		windowIcon: self windowIcon;
		"Pay attention preferredExtent: is used here because it is stateful
		in the sense that it will set the preferred extent to be remembered.
		Of course only when resizable allows it."

		whenResizingDo: [ :ann | aWindowPresenter isResizable 
									ifTrue: [ self preferredExtent: ann newSize ]].
]

{ #category : '*NewTools-Window-Profiles' }
SpPresenter >> position [

	^ self propertyAt: #position
]

{ #category : '*NewTools-Window-Profiles' }
SpPresenter >> position: aPoint [

	self propertyAt: #position put: aPoint
]
