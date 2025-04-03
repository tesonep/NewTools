Class {
	#name : 'StMessageBrowserContributor',
	#superclass : 'StPharoStyleContributor',
	#category : 'NewTools-MethodBrowsers-Messages',
	#package : 'NewTools-MethodBrowsers',
	#tag : 'Messages'
}

{ #category : 'styles' }
StMessageBrowserContributor >> styleSheetContribution [
	
	^ SpStyle newApplication 
		addClass: 'stMessageBrowserScopeList' with: [ :class | class 
			addPropertyGeometryWith: [ :geo | geo width: 220 ] ]
]
