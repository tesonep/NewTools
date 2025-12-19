Class {
	#name : 'StMessageBrowserTest',
	#superclass : 'TestCase',
	#category : 'NewTools-MethodBrowsers',
	#package : 'NewTools-MethodBrowsers'
}

{ #category : 'tests' }
StMessageBrowserTest >> testMethodBrowserClassReference [
	
	| window |
	[
	window := StMessageBrowser browseReferencesOf: 'Point' ] 
		ensure: [ window delete ]
	
]

{ #category : 'tests' }
StMessageBrowserTest >> testMethodBrowserClassReferenceHasMethods [
	
	| window |
	[
	window := StMessageBrowser browseReferencesOf: 'Point'.
	self assert: window presenter messages size > 0 ] 
		ensure: [ window delete ]
	
]
