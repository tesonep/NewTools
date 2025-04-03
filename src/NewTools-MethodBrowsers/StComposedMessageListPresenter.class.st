Class {
	#name : 'StComposedMessageListPresenter',
	#superclass : 'StMessageListPresenter',
	#category : 'NewTools-MethodBrowsers-Messages',
	#package : 'NewTools-MethodBrowsers',
	#tag : 'Messages'
}

{ #category : 'initialization' }
StComposedMessageListPresenter >> initializePresenters [

	listPresenter := self newListView.
	listPresenter
		"sortingBlock: [ :a :b | self sortClassesInCachedHierarchy: a b: b ];"
		setup: [ :aPresenter | 
			(aPresenter instantiate: StComposedMessageElementPresenter)
				messageList: self;
				yourself ];
		bind: [ :aPresenter :anElement | aPresenter model: anElement ].
		
	listPresenter outputActivationPort transmitDo: [ :aMethod | self doBrowseMethod ].
	listPresenter actions: self messageListActions
]
