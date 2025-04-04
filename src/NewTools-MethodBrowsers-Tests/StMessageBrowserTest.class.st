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
	secondMessageWindow := presenter messageList doBrowseImplementors.
	secondPresenter := secondMessageWindow presenter.
	
	self 
		assert: secondPresenter messageList selectedScope	
		equals: presenter messageList selectedScope
		
]

{ #category : 'tests' }
StMessageBrowserTest >> testAskingReferencesOfAClassShouldRespectSelectedScope [

	| presenter secondPresenter |
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.
	
	presenter toolbarPresenter scopeList selectIndex: 2.
	secondMessageWindow := presenter messageList doBrowseUsers.
	secondPresenter := secondMessageWindow presenter.
	
	self 
		assert: secondPresenter messageList selectedScope	
		equals: presenter messageList selectedScope
		
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

	| presenter anotherScope |
	anotherScope := RBClassEnvironment classes: {self class. StMBTestClass}.
	
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation inScope: anotherScope.
	presenter := messageBrowser presenter.
	
	self assert: presenter messageList selectedScope equals: anotherScope
]

{ #category : 'tests' }
StMessageBrowserTest >> testOpeningWithASpecificScopeIncludesItInTheList [

	| presenter anotherScope |
	anotherScope := RBClassEnvironment classes: {self class. StMBTestClass}.
	
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation inScope: anotherScope.
	presenter := messageBrowser presenter.
	
	self assert: (presenter toolbarPresenter scopeList items includes:anotherScope)
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

{ #category : 'tests' }
StMessageBrowserTest >> testScopeListHasCorrectNumberOfElements [

	| presenter |

	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.
	self assert: presenter toolbarPresenter scopeList items size equals: 4 "Current Image, Package and Class, hierarchy"
]

{ #category : 'tests' }
StMessageBrowserTest >> testScopeListHasCorrectOrder [

	| presenter |
	messageBrowser := StMessageBrowser browseImplementorsOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.


	self
		assertCollection: (presenter toolbarPresenter scopeList items collect: #description)
		hasSameElements: { 'Current image'. 'Packages: NewTools-MethodBrowsers-Tests'. 'Hier: StMBTestClass'. 'Classes: StMBTestClass' }
]

{ #category : 'tests' }
StMessageBrowserTest >> testSelectingElementsDoesNotDuplicateScopes [

	| presenter |

	messageBrowser := StMessageBrowser browseSendersOf: #aSelectorWithASingleMethodImplementation.
	presenter := messageBrowser presenter.
	self assert: presenter toolbarPresenter scopeList items size equals: 4.
	
	presenter messageList selectIndex: 2.
	
	self assert: presenter toolbarPresenter scopeList items size equals: 4.

]
