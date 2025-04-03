Class {
	#name : 'StComposedMessageBrowser',
	#superclass : 'StMessageBrowser',
	#category : 'NewTools-MethodBrowsers-Messages',
	#package : 'NewTools-MethodBrowsers',
	#tag : 'Messages'
}

{ #category : 'initialization' }
StComposedMessageBrowser >> newMessageList [

	^ self instantiate: StComposedMessageListPresenter
]
