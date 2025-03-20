"
I'm able to detect all the cycles in a package dependency graph.

Analysis is done in three steps: build the dependency graph, isolating the strongly connected components (SCC), and for each SCC detect all the elementary cycles.

Use the message runAlgorithm to run the algorithm to retrieve the elementary cycles in the package dependency graph.

 At the end, all the cycles are in the collection ""cycles"".
"
Class {
	#name : 'StPackageCycleDetector',
	#superclass : 'Object',
	#instVars : [
		'sccs',
		'cycles',
		'visitedNodes',
		'queue',
		'relationGraph'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StPackageCycleDetector class >> collections [
	^ (self onPackagesNamed: #('Collections-Abstract' 'Collections-Arithmetic' 'Collections-Arrayed' 'Collections-Atomic' 'Collections-Native' 'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams' 'Collections-Strings' 'Collections-Support' 'Collections-Traits' 'Collections-Unordered' 'Collections-Weak')) runAlgorithm
]

{ #category : 'instance creation' }
StPackageCycleDetector class >> morphic [
	^ (self onPackagesNamed: #('Morphic-Base' 'Morphic-Core' 'Morphic-Examples' 'MorphicTests' 'Spec-MorphicAdapters')) runAlgorithm
]

{ #category : 'instance creation' }
StPackageCycleDetector class >> new [
	^ self onPackagesNamed: #()
]

{ #category : 'instance creation' }
StPackageCycleDetector class >> onPackagesNamed: aCollection [

	^ self basicNew
		  initializeWith: aCollection;
		  yourself
]

{ #category : 'instance creation' }
StPackageCycleDetector class >> system [
	^ (self onPackagesNamed:
		(self packageOrganizer packages collect: [ :package | package packageName asString ])) runAlgorithm
]

{ #category : 'adding' }
StPackageCycleDetector >> addCycle: aPDPackageCycle [
	cycles add: aPDPackageCycle
]

{ #category : 'adding' }
StPackageCycleDetector >> addVisitedNodes: aNode [
	visitedNodes add: aNode
]

{ #category : 'actions' }
StPackageCycleDetector >> buildCycleUntil: children [
	| aPackageCycle currentNode |
	aPackageCycle := StPackageCycle new.
	currentNode := children.
	[ currentNode isNil ]
		whileFalse: [
			aPackageCycle addPackage: currentNode.
			currentNode := currentNode bfsParent ].
	(self cycleAlreadyFound: aPackageCycle)
		ifFalse: [
			aPackageCycle reversedCycle.
			self addCycle: aPackageCycle ]
]

{ #category : 'accessing' }
StPackageCycleDetector >> childrensFrom: stronglyConnectedComponents for: aNode [
	^ stronglyConnectedComponents successors: aNode
]

{ #category : 'testing' }
StPackageCycleDetector >> cycleAlreadyFound: aPackageCycle [
	^ cycles anySatisfy: [ :cycle | cycle = aPackageCycle ]
]

{ #category : 'accessing' }
StPackageCycleDetector >> cycles [
	^ cycles sorted: [ :a :b | a size < b size ]
]

{ #category : 'accessing' }
StPackageCycleDetector >> cycles: anObject [
	cycles := anObject
]

{ #category : 'accessing' }
StPackageCycleDetector >> cyclesWith: aPDPackage [
	^ cycles select: [ :cycle |
			cycle isInCycle: aPDPackage
		 ]
]

{ #category : 'accessing' }
StPackageCycleDetector >> cyclesWithAtLeast: aCollectionOfPDPackage [
	^ cycles select: [ :cycle | cycle isAtLeastInCycle: aCollectionOfPDPackage ]
]

{ #category : 'actions' }
StPackageCycleDetector >> dequeue [
	| aNode |
	aNode := queue nextOrNil.
	aNode ifNotNil: [ aNode inStack: false ].
	^ aNode
]

{ #category : 'actions' }
StPackageCycleDetector >> enqueue: aNode [
	queue nextPut: aNode
]

{ #category : 'actions' }
StPackageCycleDetector >> findAllCyclesFrom: stronglyConnectedComponents for: package [
	| parents |
	self initializeVisitedNodes.
	parents := self parentsFrom: stronglyConnectedComponents For: package.
	self initializeQueueWith: package.
	 [ parents isEmpty ] whileFalse: [ self startBfsFrom: stronglyConnectedComponents For: parents ]
]

{ #category : 'actions' }
StPackageCycleDetector >> findCycles: stronglyConnectedComponents [
	stronglyConnectedComponents packages
		do: [ :package |
			self findAllCyclesFrom: stronglyConnectedComponents for: package
			]
]

{ #category : 'initialization' }
StPackageCycleDetector >> initialize [
	super initialize.
	cycles := SortedCollection new.
	sccs := OrderedCollection new
]

{ #category : 'initialization' }
StPackageCycleDetector >> initializeQueueWith: package [

	package bfsParent: nil.
	package inStack: true.
	queue := WaitfreeQueue new.
	queue nextPut: package
]

{ #category : 'initialization' }
StPackageCycleDetector >> initializeVisitedNodes [

	visitedNodes := Set new
]

{ #category : 'initialization' }
StPackageCycleDetector >> initializeWith: packageNames [

	relationGraph := StPackageRelationGraph onPackages: (packageNames collect: [ :packageName | StPackage onPackageNamed: packageName ]).
	cycles := OrderedCollection new.
	self relationGraph build.
	sccs := self runTarjan
]

{ #category : 'testing' }
StPackageCycleDetector >> isVisitedOrInQueue: aNode [
	^ (visitedNodes includes: aNode) or: [ aNode isInStack ]
]

{ #category : 'accessing' }
StPackageCycleDetector >> parentsFrom: stronglyConnectedComponents For: aNode [
	^ stronglyConnectedComponents predecessors: aNode
]

{ #category : 'accessing' }
StPackageCycleDetector >> refresh [
	self relationGraph refreshGraph.
	self
		reset;
		runAlgorithm
]

{ #category : 'accessing' }
StPackageCycleDetector >> relationGraph [
	^ relationGraph
]

{ #category : 'initialization' }
StPackageCycleDetector >> reset [
	cycles := SortedCollection new.
	visitedNodes := nil.
	queue := nil
]

{ #category : 'actions' }
StPackageCycleDetector >> runAlgorithm [
	self stronglyConnectedComponents
		do: [ :scc | self findCycles: scc ]
		displayingProgress: 'finding cycles'
]

{ #category : 'actions' }
StPackageCycleDetector >> runTarjan [

    ^ AITarjan new runOnDAPackageRelationGraph: self relationGraph
]

{ #category : 'actions' }
StPackageCycleDetector >> startBfsFrom: stronglyConnectedComponents For: parents [
	| dequeue childrens |
	dequeue := self dequeue.
	childrens := self childrensFrom: stronglyConnectedComponents for: dequeue.
	childrens
		do: [ :children |
			(self isVisitedOrInQueue: children)
				ifFalse: [
					children bfsParent: dequeue.
					self enqueue: children ].
			(parents includes: children)
				ifTrue: [
					self buildCycleUntil: children.
					parents remove: children ] ].
	self addVisitedNodes: dequeue
]

{ #category : 'accessing' }
StPackageCycleDetector >> stronglyConnectedComponents [
	^ sccs
]

{ #category : 'accessing' }
StPackageCycleDetector >> visitedNodes [
	^ visitedNodes
]
