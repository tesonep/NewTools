"
I implement the lookup of #Senders and the Meta + n binding.

"
Class {
	#name : 'StSendersProcessor',
	#superclass : 'StSpotterProcessor',
	#category : 'NewTools-Spotter-Processors-Processors',
	#package : 'NewTools-Spotter-Processors',
	#tag : 'Processors'
}

{ #category : 'default-settings' }
StSendersProcessor class >> defaultEnabled [

	^ true
]

{ #category : 'accessing' }
StSendersProcessor class >> order [
	
	^ 130
]

{ #category : 'accessing' }
StSendersProcessor class >> title [
	
	^ 'Senders'
]

{ #category : 'testing' }
StSendersProcessor >> askingForSenders [

	^ query hasCategoryMatching: #s
]

{ #category : 'testing' }
StSendersProcessor >> categoriesIncludes: aCategory [

	^ aCategory asLowercase beginsWith: #s
]

{ #category : 'filtering' }
StSendersProcessor >> executeQuery [

	self askingForSenders ifFalse: [ ^ self ].
	^ super executeQuery 
]

{ #category : 'key-bindings' }
StSendersProcessor >> installKeymappingsOn: aPresenter onExecution: aBlock [

	aPresenter addShortcutWith: [ :action | action 
		shortcutKey: self keyBinding;
		action: [ 
			self query toggleFilter: self sendersTag.
			aBlock cull: self ] ]
]

{ #category : 'spotter-api' }
StSendersProcessor >> isRelevantForQuery: aString [ 
	
	^ true
]

{ #category : 'key-bindings' }
StSendersProcessor >> keyBinding [

	^ $n meta
]

{ #category : 'filtering' }
StSendersProcessor >> newTextFilteringSource [

	^ StSendersIterator new 
]

{ #category : 'key-bindings' }
StSendersProcessor >> sendersTag [
		
	^ #Senders
]
