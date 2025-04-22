"
I am a presenter listing messages. 

I am used by more complexe browsers such as MessageBrowser or VersionBrowser.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	cachedHierarchy:		<aDictionary>	 	A cache keeping info about the level of a class in the list.
	listModel:				<aListPresenter>	A list presenter to show all the messages.
	model:						<aTool>				A model grouping generic methods for managing packages/classes/groups/methods from a browser
	topologySort:			<aBoolean>		 	A boolean to know if we should use a topology sort or not.

"
Class {
	#name : 'StMessageListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'cachedHierarchy',
		'topologySort',
		'listPresenter',
		'scopes',
		'allMessages',
		'selectedScope'
	],
	#category : 'NewTools-MethodBrowsers-Messages',
	#package : 'NewTools-MethodBrowsers',
	#tag : 'Messages'
}

{ #category : 'layout' }
StMessageListPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: #listPresenter;
		yourself
]

{ #category : 'private - scopes' }
StMessageListPresenter >> browserEnvironment [

	^ RBBrowserEnvironment default label: 'current image'
]

{ #category : 'testing' }
StMessageListPresenter >> buildHierarchyForMessages: messages [
	| result classes |
	self topologicSort ifFalse: [ 
		result := IdentityDictionary new.
		messages do: [:m | result at: m put: {} ].
		^ result ].
	
	result := Dictionary new.	
	classes := (messages collect: [ :each | each methodClass ]) asSet.
	messages do: [:message || level class |
		class := message methodClass.
		level := OrderedCollection new.
		class allSuperclassesDo: [:superClass |
			(classes includes: superClass)
				ifTrue: [ level addFirst: superClass ]].
		level addLast: class.
		level addLast: message selector.
		result at: message put: level ].
	^ result
]

{ #category : 'testing' }
StMessageListPresenter >> cacheHierarchyForClasses: aCollection [
	cachedHierarchy := self buildHierarchyForMessages: aCollection.
]

{ #category : 'private - scopes' }
StMessageListPresenter >> classEnvironmentFor: aClass [
	"Answer a <RBClassEnvironment> for aClass"

	^ RBBrowserEnvironment default forClasses: { aClass }


]

{ #category : 'private - scopes' }
StMessageListPresenter >> classHierarchyEnvironmentFor: aClass [
	"Answer a <RBClassEnvironment> for aClass"

	^ RBBrowserEnvironment default forClassHierarchy: aClass


]

{ #category : 'private' }
StMessageListPresenter >> classOf: aCompiledMethod [
	"Answer the <Class> of aCompiledMethod"

	^ aCompiledMethod methodClass
]

{ #category : 'private - scopes' }
StMessageListPresenter >> classesEnvironments [
	"Answer a <Collection> of <RBClassEnvironment> for the receiver's selected classes"
	
	^ self visitedScopes 
		select: [ : anObject | anObject isClass ]
		thenCollect: [ : aClass | self classEnvironmentFor: aClass  ]
]

{ #category : 'private - scopes' }
StMessageListPresenter >> compositeEnvironments [

	^ self visitedScopes reject: [ : anObject | anObject isClass or: [ anObject isPackage ] ]


]

{ #category : 'transmission' }
StMessageListPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : 'private - scopes' }
StMessageListPresenter >> defaultScopes [
	"Private - By default we answer the <Package> of the currently selected item"

	| defaultScopes |
	defaultScopes := Set new.
	
	defaultScopes 
		add: self browserEnvironment;
		addAll: ScopesManager availableScopes.

	self selectedMessage
		ifNotNil: [ 
			defaultScopes
				add: (self packageEnvironmentFor: (self packageOf: self selectedMessage));
				add: (self classEnvironmentFor: (self classOf: self selectedMessage));
				add: (self classHierarchyEnvironmentFor: (self classOf: self selectedMessage))].
			
	^ defaultScopes
]

{ #category : 'private - actions' }
StMessageListPresenter >> doBrowseImplementors [
	
	^ StMessageBrowser browseImplementorsOf: self selectedMethod selector inScope: selectedScope 
]

{ #category : 'private - actions' }
StMessageListPresenter >> doBrowseMethod [
		
	self systemNavigation browse: self selectedMethod
]

{ #category : 'private - actions' }
StMessageListPresenter >> doBrowseSenders [

	^ StMessageBrowser browseSendersOf: self selectedMethod selector inScope: selectedScope 
]

{ #category : 'private - actions' }
StMessageListPresenter >> doBrowseUsers [

	| window |
	
	window := self systemNavigation browseAllUsersOfClassOrTrait: self selectedMethod methodClass.
	window presenter switchScopeTo: self selectedScope.
	^ window
]

{ #category : 'private - actions' }
StMessageListPresenter >> doBrowseVersions [
	
	self systemNavigation browseVersionsOf: self selectedMethod
]

{ #category : 'private - actions' }
StMessageListPresenter >> doInspectMethod [
	
	self systemNavigation inspect: self selectedMethod
]

{ #category : 'private - actions' }
StMessageListPresenter >> doRemoveMethod [

	self selectedMessages ifNotEmpty: [ :someMethods |
			(ReRemoveMethodDriver new
				 scopes: self sortedScopes
				 methods: someMethods) runRefactoring ]
]

{ #category : 'initialization' }
StMessageListPresenter >> initialize [

	super initialize.
	topologySort := true.
	allMessages := Set empty.
]

{ #category : 'initialization' }
StMessageListPresenter >> initializePresenters [

	listPresenter := self newTable.
	listPresenter
		sortingBlock: [ :a :b | self sortClassesInCachedHierarchy: a b: b ];
		addColumn: (SpStringTableColumn 
			title: 'Location' 
			evaluated: [ :item | self locationOf: item ]);
		addColumn: (SpStringTableColumn 
			title: 'Selector' 
			evaluated: [ :item | self selectorOf: item ]);
		addColumn: (SpStringTableColumn 
			title: 'Package' 
			evaluated: [ :item | self packageNameOf: item ]);
		beResizable.

	listPresenter outputActivationPort transmitDo: [ :aMethod | self doBrowseMethod ].
	listPresenter actions: self messageListActions
]

{ #category : 'accessing' }
StMessageListPresenter >> listPresenter [

	^ listPresenter
]

{ #category : 'accessing' }
StMessageListPresenter >> locationOf: anItem [

	| protocolOrOriginName |
	^ String streamContents: [ :aStream | 
		3 to: (cachedHierarchy at: anItem) size do: [ :i | aStream << '    ' ].
		protocolOrOriginName := anItem isFromTrait
			ifTrue: [ anItem compiledMethod origin name ]
			ifFalse: [ self protocolNameForItem: anItem ].

		aStream  << (self methodClassNameForItem: anItem).
					
		protocolOrOriginName ifNotEmpty: [ 
				aStream 
					<< ' (';
					<< protocolOrOriginName;
					<< ' )' ]
		 ]
]

{ #category : 'private' }
StMessageListPresenter >> messageListActions [
	
	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup forSpecNamed: 'View')
			beDisplayedAsGroup;
			register: (StMessageBrowseFullCommand forSpecContext: self);
			register: (StMessageInspectMethodCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup forSpecNamed: 'Navigation')
			beDisplayedAsGroup;
			register: (StMessageSendersCommand forSpecContext: self);
			register: (StMessageImplementorsCommand forSpecContext: self);
			register: (StMessageUsersCommand forSpecContext: self);
			register: (StMessageVersionsCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup forSpecNamed: 'CRITICAL')
			beDisplayedAsGroup;
			register: (StMessageRemoveMethodCommand forSpecContext: self);
			yourself);
		yourself
]

{ #category : 'accessing' }
StMessageListPresenter >> messages [

	^ listPresenter items
]

{ #category : 'accessing' }
StMessageListPresenter >> messages: aCollection [

	self cacheHierarchyForClasses: aCollection.
	listPresenter items: cachedHierarchy keys asOrderedCollection.
	allMessages := listPresenter items.
	listPresenter listSize > 0 ifTrue: [ 
		listPresenter selectIndex: 1 ]
]

{ #category : 'private' }
StMessageListPresenter >> methodClassNameForItem: anItem [
	^ anItem methodClass ifNotNil: [ :class | class name ] ifNil: [ '' ]
]

{ #category : 'accessing' }
StMessageListPresenter >> numberOfElements [

	^ listPresenter listSize
]

{ #category : 'transmission' }
StMessageListPresenter >> outputActivationPort [

	^ (SpActivationPort newPresenter: self)
		delegateTo: [ listPresenter ];
		yourself
]

{ #category : 'transmission' }
StMessageListPresenter >> outputSelectionPort [

	^ (SpSelectionPort newPresenter: self)
		delegateTo: [ listPresenter ];
		yourself
]

{ #category : 'private - scopes' }
StMessageListPresenter >> packageEnvironmentFor: aPackage [
	"Answer a <RBPackageEnvironment> for the selected packages"

	^ RBBrowserEnvironment default forPackages: { aPackage }


]

{ #category : 'private' }
StMessageListPresenter >> packageNameForItem: anItem [
	^ anItem package ifNil: [ '' ] ifNotNil: [ :package | package name ]
]

{ #category : 'private' }
StMessageListPresenter >> packageNameOf: anItem [
	"Answer a <String> matching anItem"

	^ '[' , (self packageNameForItem: anItem) , ']'
]

{ #category : 'private' }
StMessageListPresenter >> packageOf: aCompiledMethod [
	"Answer the <Package> of aCompiledMethod"

	^ self packageOrganizer packageOf: aCompiledMethod methodClass
]

{ #category : 'private' }
StMessageListPresenter >> protocolNameForItem: anItem [

	^ anItem protocolName ifNil: [ '' ]
]

{ #category : 'private - scopes' }
StMessageListPresenter >> scopes [
	"Answer a <Collection> of the receiver's message list scopes"
	
	^ scopes ifNil: [ scopes := self defaultScopes ]
]

{ #category : 'selecting' }
StMessageListPresenter >> selectIndex: anInteger [

	listPresenter selectIndex: anInteger
]

{ #category : 'selecting' }
StMessageListPresenter >> selectedIndex [

	^ listPresenter selection selectedIndex
]

{ #category : 'accessing' }
StMessageListPresenter >> selectedItem [
	
	^ listPresenter selectedItem 
]

{ #category : 'accessing' }
StMessageListPresenter >> selectedMessage [

	^ listPresenter selection selectedItem
]

{ #category : 'selection' }
StMessageListPresenter >> selectedMessages [
	
	^ self listPresenter selectedItems
]

{ #category : 'accessing' }
StMessageListPresenter >> selectedMethod [

	self selectedMessage ifNil: [ ^ nil ].
	^ self selectedMessage compiledMethod
]

{ #category : 'accessing' }
StMessageListPresenter >> selectedScope [
	^ selectedScope
]

{ #category : 'accessing' }
StMessageListPresenter >> selectorOf: anItem [

	^ anItem selector
]

{ #category : 'accessing - model' }
StMessageListPresenter >> setModelBeforeInitialization: aMethod [
]

{ #category : 'sorting' }
StMessageListPresenter >> sortClassesInCachedHierarchy: aMethodDefinition b: otherMethodDefinition [
	"This method checks wether the cached inheritance hierarchy of a method should be before than the one of another method.
	It compares alphabetically the hierarchy using #compare:
	If both are alphabetically equals, it uses the size the hierarchy.
	We do not know why this is done like this."
	| aMethodHierarchy otherMethodHierarchy minSize|
	aMethodHierarchy := cachedHierarchy at: aMethodDefinition.
	otherMethodHierarchy := cachedHierarchy at: otherMethodDefinition.
	
	minSize := aMethodHierarchy size min: otherMethodHierarchy size.
	
	1 to: minSize do: [ :i | |compare|
		compare := (aMethodHierarchy at: i) printString compare: (otherMethodHierarchy at: i) printString.
		compare ~~ 2
			ifTrue: [  ^ compare == 1 ]].
	^  aMethodHierarchy size < otherMethodHierarchy size
]

{ #category : 'private - scopes' }
StMessageListPresenter >> sortedScopes [
	
	^ scopes asOrderedCollection sort: [ :a :b | a scopeListOrder < b scopeListOrder ]
]

{ #category : 'api' }
StMessageListPresenter >> sortingBlock: aBlock [

	listPresenter sortingBlock: aBlock
]

{ #category : 'private - scopes' }
StMessageListPresenter >> switchScopeTo: aRBBrowserEnvironment [
	| messages |

	selectedScope = aRBBrowserEnvironment ifTrue: [ ^ self ].

	selectedScope := aRBBrowserEnvironment.
	self scopes add: selectedScope.

	messages := aRBBrowserEnvironment selectMessagesFrom: allMessages.
	listPresenter items: messages.

	messages ifNotEmpty: [ listPresenter selectIndex: 1 ]
]

{ #category : 'accessing' }
StMessageListPresenter >> topologicSort [

	^ topologySort
]

{ #category : 'accessing' }
StMessageListPresenter >> topologicSort: anObject [

	topologySort := anObject
]

{ #category : 'private - scopes' }
StMessageListPresenter >> updateScopesFrom: aMethod [

	self scopes
		add: (self packageEnvironmentFor: (self packageOf: aMethod));
		add: (self classEnvironmentFor: (self classOf: aMethod));
		add: (self classHierarchyEnvironmentFor: (self classOf: aMethod))
]

{ #category : 'api - events' }
StMessageListPresenter >> whenModelChangedDo: aBlock [
	listPresenter whenModelChangedDo: aBlock
]

{ #category : 'api - events' }
StMessageListPresenter >> whenSelectedDo: aBlock [

	listPresenter whenSelectedDo: aBlock
]

{ #category : 'api - events' }
StMessageListPresenter >> whenSelectionChangedDo: aBlock [

	listPresenter whenSelectionChangedDo: aBlock
]
