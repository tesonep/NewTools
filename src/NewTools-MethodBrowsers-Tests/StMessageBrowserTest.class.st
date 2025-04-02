Class {
	#name : 'StMessageBrowserTest',
	#superclass : 'TestCase',
	#instVars : [
		'messageBrowser'
	],
	#category : 'NewTools-MethodBrowsers-Tests',
	#package : 'NewTools-MethodBrowsers-Tests'
}

{ #category : 'running' }
StMessageBrowserTest >> tearDown [

	messageBrowser ifNotNil: [ messageBrowser close ].
	super tearDown
]

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningAMessageBrowserOnASingleMethodHasCorrectTitle [

	messageBrowser := StMessageBrowser browse: { StMBTestClass >> #aSelectorWithASingleMethodImplementation }.
	
	self assert: messageBrowser title equals: 'Message Browser [1]'
]

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningImplementorsAndChangingScopeShowsCorrectTitle [

	| presenter |
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.
	
	presenter toolbarPresenter scopeList selectIndex: 2.
	
	self assert: messageBrowser title equals: 'Implementors of #aSelectorWithASingleMethodImplementation [1]'
]

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningImplementorsShowsCorrectTitle [

	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	
	self assert: messageBrowser title equals: 'Implementors of #aSelectorWithASingleMethodImplementation [1]'
]

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningImplementorsWithASingleImplementationHasOneAndSelectsIt [

	| presenter |
	messageBrowser := StMessageBrowser browseImplementorsOf:
		                  #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.

	self assert: presenter messageList listPresenter model size equals: 1.

	self
		assert: (presenter messageList listPresenter model at: 1)
		equals: StMBTestClass >> #aSelectorWithASingleMethodImplementation.
		
	self 
		assert: (presenter textPresenter text) equals: (StMBTestClass >> #aSelectorWithASingleMethodImplementation) sourceCode
]
