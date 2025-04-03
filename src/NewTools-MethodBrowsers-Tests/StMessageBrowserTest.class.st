Class {
	#name : 'StMessageBrowserTest',
	#superclass : 'TestCase',
	#instVars : [
		'messageBrowser',
		'secondMessageWindow'
	],
	#category : 'NewTools-MethodBrowsers-Tests',
	#package : 'NewTools-MethodBrowsers-Tests'
}

{ #category : 'running' }
StMessageBrowserTest >> tearDown [

	messageBrowser ifNotNil: [ messageBrowser close ].
	secondMessageWindow ifNotNil: [ secondMessageWindow close ].
	super tearDown
]

{ #category : 'tests' }
StMessageBrowserTest >> testAskingImplementorsOfASelectorShouldRespectSelectedScope [

	| presenter secondPresenter |
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.
	
	presenter toolbarPresenter scopeList selectIndex: 2.
	presenter messageList selectIndex: 1.
	
	secondMessageWindow := presenter messageList doBrowseImplementors.
	secondPresenter := secondMessageWindow presenter.
	
	self 
		assert: presenter messageList selectedScope
		equals: secondPresenter messageList selectedScope	
		
]

{ #category : 'tests' }
StMessageBrowserTest >> testAskingReferencesOfAClassShouldRespectSelectedScope [

	self fail
]

{ #category : 'tests' }
StMessageBrowserTest >> testAskingSendersOfASelectorShouldRespectSelectedScope [

	| presenter secondPresenter |
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.
	
	presenter toolbarPresenter scopeList selectIndex: 2.
	presenter messageList selectIndex: 1.
	
	secondMessageWindow := presenter messageList doBrowseSenders.
	secondPresenter := secondMessageWindow presenter.
	
	self 
		assert: presenter messageList selectedScope
		equals: secondPresenter messageList selectedScope	

]

{ #category : 'tests' }
StMessageBrowserTest >> testModifyingAMethodModifiesIt [

	self fail
]

{ #category : 'tests' }
StMessageBrowserTest >> testModifyingTheSelectorCompilesNewCode [

	self fail
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

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningWithASpecificScopeActivatesIt [

	self fail
]

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningWithASpecificScopeIncludesItInTheList [

	self fail
]

{ #category : 'tests' }
StMessageBrowserTest >> testRemovingAMethodCallsTheRefactoring [

	| presenter mockSelectDialog |

	messageBrowser := StMessageBrowser browseImplementorsOf:
		                  #aSelectorWithASingleMethodImplementation.

	presenter := messageBrowser presenter.
	
	mockSelectDialog := MockObject new.
	mockSelectDialog
		on: #title: with: MockObject any;
		on: #label: with: 'Select a strategy';
		on: #items: with: MockObject any;
		on: #display: with: MockObject any;
		on: #displayIcon: with: MockObject any;
		on: #openModal respond: nil "When cancelling the dialog, nil is returned".
	
	ReInteractionDriver useSelectDialog: mockSelectDialog during: [presenter messageList doRemoveMethod].

	mockSelectDialog verifyIn: self.
]
