"
I analyze package sent messages to reveal dependencies.

Examples:
(self on: 'Kernel') difference
(self on: 'Kernel') missingMethodsWithPotentialMatch
(self on: 'Kernel') possibleDeadCode
(self on: 'Kernel') missingDependencies
(self on: 'Kernel') 	missingMethodsWithPotentialMatchAfterMissingDependenciesAddition

"
Class {
	#name : 'StMessageSendAnalyzer',
	#superclass : 'Object',
	#instVars : [
		'packageAnalysis',
		'missingMethods'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StMessageSendAnalyzer class >> on: aPackageName [
	| packageAnalysis |
	packageAnalysis := ((StPackageRelationGraph onPackagesNamed: { aPackageName })
				build;
				packages)
			select: #isSeen.
	^ self basicNew
		initializeWith: packageAnalysis first;
		yourself
]

{ #category : 'utilities' }
StMessageSendAnalyzer class >> packagesProvidingSelector: aSelector [
	^ aSelector implementors
		collect: [:each | each package name]
		as: Set
]

{ #category : 'computing' }
StMessageSendAnalyzer >> implementedMessages [

	^ (self packageStaticDependencies
		   add: self packageName;
		   yourself) flatCollect: [ :name | (self packageOrganizer packageNamed: name) selectors ]
]

{ #category : 'computing' }
StMessageSendAnalyzer >> implementedMessagesWithManuallyResolvedDependencies [

	^ (self manuallyResolvedDependencies flatCollect: [ :name | (self packageOrganizer packageNamed: name) selectors ] as: Set)
		  addAll: self implementedMessages;
		  yourself
]

{ #category : 'initialization' }
StMessageSendAnalyzer >> initializeWith: aDAPackage [
	packageAnalysis := aDAPackage
]

{ #category : 'accessing' }
StMessageSendAnalyzer >> manuallyResolvedDependencies [

	^ self systemPackage manuallyResolvedDependencies
]

{ #category : 'computing' }
StMessageSendAnalyzer >> missingDependencies [
	^ (self missingMethodsWithPotentialMatch
		select: [ :each | each size = 1 ]) flattened asSet
]

{ #category : 'accessing' }
StMessageSendAnalyzer >> missingMethods [
	^ self missingMethodsWithPotentialMatch keys
]

{ #category : 'computing' }
StMessageSendAnalyzer >> missingMethodsImplementedIn: aPackageName [

	| rPackage |
	rPackage := self packageOrganizer packageNamed: aPackageName ifAbsent: [
		            StUnknownManuallyResolvedPackage signalOn: aPackageName.
		            ^ self missingMethods ].

	^ rPackage selectors intersection: self missingMethods
]

{ #category : 'computing' }
StMessageSendAnalyzer >> missingMethodsWithPotentialMatch [
	^ missingMethods ifNil:
		[ missingMethods := Dictionary new.
		self unimplementedCalls do: [ :selector |
		missingMethods
			at: selector
			put: (self packagesProvidingSelector: selector) ].
		missingMethods ]
]

{ #category : 'computing' }
StMessageSendAnalyzer >> missingMethodsWithPotentialMatchAfterManuallyResolvedDependenciesAddition [
	| dictionary |

	dictionary := Dictionary new.
	self unimplementedCallsInAllDependencies do: [ :selector |
		dictionary
			at: selector
			put: (self packagesProvidingSelector: selector) ].
	^ dictionary
]

{ #category : 'accessing' }
StMessageSendAnalyzer >> packageName [
	^ packageAnalysis packageName
]

{ #category : 'accessing' }
StMessageSendAnalyzer >> packageStaticDependencies [
	^ packageAnalysis dependencies
		collect: [:each | each target packageName ]
		as: Set
]

{ #category : 'computing' }
StMessageSendAnalyzer >> packagesProvidingSelector: aSelector [
	^ self class packagesProvidingSelector: aSelector
]

{ #category : 'computing' }
StMessageSendAnalyzer >> possibleDeadCode [
	^ self missingMethodsWithPotentialMatch
		select: #isEmpty
]

{ #category : 'computing' }
StMessageSendAnalyzer >> sentMessages [

	^self systemPackage methods flatCollect: #messages as: Set
]

{ #category : 'accessing' }
StMessageSendAnalyzer >> systemPackage [
	"Answer a <Package> matching the receiver's package name. If we are browsing an unloaded package, then answer a virtual RPackage so the message send analyzer could preserve its behavior with loaded packages in #manuallyResolvedDependencies"

	^ packageAnalysis systemPackage ifNil: [ Package named: 'Virtual' , self packageName ]
]

{ #category : 'computing' }
StMessageSendAnalyzer >> unimplementedCalls [
	^ self sentMessages difference: self implementedMessages
]

{ #category : 'computing' }
StMessageSendAnalyzer >> unimplementedCallsInAllDependencies [
	^ self sentMessages difference: self implementedMessagesWithManuallyResolvedDependencies
]
