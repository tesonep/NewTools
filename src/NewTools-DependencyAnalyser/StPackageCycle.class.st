"
A PDPackageCycle is used to represent a cycle among packages. 	
All the packages in the cycle are stored in a Collection, in the their name alphabetical order.

As soon as possible, they will be stored in the order they have been found.
"
Class {
	#name : 'StPackageCycle',
	#superclass : 'Object',
	#instVars : [
		'packages'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StPackageCycle class >> new [
	^ self basicNew initialize; yourself
]

{ #category : 'comparing' }
StPackageCycle >> <= aPDPackageCycle [
	^ (self size) <= (aPDPackageCycle size)
]

{ #category : 'comparing' }
StPackageCycle >> = aPDPackageCycle [
	(aPDPackageCycle isKindOf: self class) ifFalse: [ ^ false ].
	^ self size = aPDPackageCycle size and: [ self packages includesAll: aPDPackageCycle packages ]
]

{ #category : 'comparing' }
StPackageCycle >> > aPDPackageCycle [
	^ (self size) > (aPDPackageCycle size)
]

{ #category : 'adding' }
StPackageCycle >> addAllPackages: aCollection [

	aCollection do: [ :package | self addPackage: package]
]

{ #category : 'adding' }
StPackageCycle >> addPackage: aPDPackage [
	packages add: aPDPackage
]

{ #category : 'accessing' }
StPackageCycle >> dependentPackagesFrom: aPackage [
	"only the dependent packages from the cycle"
	^ aPackage dependentPackages select: [ :package |
		self packages includes: package
		 ]
]

{ #category : 'displaying' }
StPackageCycle >> displayString [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'A cycle of ';
			print: self size;
			nextPutAll: ' packages : '.
		packages
			do: [ :package | stream nextPutAll: package packageName ]
			separatedBy: [ stream space ] ]
]

{ #category : 'testing' }
StPackageCycle >> hasOutgoingDependencies: aPackage [
	^ aPackage dependencies anySatisfy: [ :dependency | (self packages includes: (dependency target)) not ]
]

{ #category : 'comparing' }
StPackageCycle >> hash [
	^ self packages hash
]

{ #category : 'initialization' }
StPackageCycle >> initialize [
	super initialize.
	packages := OrderedCollection new
]

{ #category : 'testing' }
StPackageCycle >> isAtLeastInCycle: aCollectionOfPDPackage [
	^ aCollectionOfPDPackage anySatisfy: [ :package | self isInCycle: package ]
]

{ #category : 'testing' }
StPackageCycle >> isInCycle: aPackage [
	^ packages includes: aPackage
]

{ #category : 'accessing' }
StPackageCycle >> packageAt: anInteger [
	^ packages at: anInteger
]

{ #category : 'accessing' }
StPackageCycle >> packages [
	^ packages
]

{ #category : 'accessing' }
StPackageCycle >> packages: anObject [
	packages := anObject
]

{ #category : 'actions' }
StPackageCycle >> removeOutgoingDependencies [
	self packages do: [ :package | self removeOutgoingDependencies: package ]
]

{ #category : 'private' }
StPackageCycle >> removeOutgoingDependencies: aPackage [

	| removals |
	packages := packages copy.
	removals := aPackage dependencies reject: [ :dependency | self packages includes: (dependency target) ].

	removals do: [ :each | aPackage remove: each ]
]

{ #category : 'accessing' }
StPackageCycle >> reversedCycle [
	packages := packages reversed
]

{ #category : 'accessing' }
StPackageCycle >> size [
	^ packages size
]
