"
I represent a system package (`RPackageSet`) and I store all its dependencies (`DAPackageDependency`).

Instance variables :

- dependencies : a collection of `DAPackageDependency` (actually the nodes of a graph dependency, from a source DAPackage to a target DAPackage)
- included : says if the DAPackage is included or not, at the beginning, in the set of packages.
- systemPackage : the instance of the package in the system if it is loaded 	
- inStack : useful for tarjan algorithm and cycle algorithm. It avoids stack access
- tarjanIndex and tarjanLowLink : integer for the tarjan algorithm.
- bfsParent : see cycle algorithm
- seen : says if all dependencies have been added to the Package
"
Class {
	#name : 'StPackage',
	#superclass : 'Object',
	#instVars : [
		'dependencies',
		'included',
		'inStack',
		'tarjanIndex',
		'tarjanLowLink',
		'bfsParent',
		'seen',
		'systemPackage',
		'packageName'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StPackage class >> new [
	self shouldNotImplement
]

{ #category : 'instance creation' }
StPackage class >> onPackageNamed: aString [
	"In the future we should manage different environment and not go into the global one."

	^ self basicNew
		  initializeWithPackage: (self packageOrganizer packageNamed: aString ifAbsent: [ nil ]);
		  packageName: aString;
		  yourself
]

{ #category : 'comparing' }
StPackage >> <= aPackage [
	^ (self packageName asString) <= (aPackage packageName asString)
]

{ #category : 'comparing' }
StPackage >> = aPackage [
	(aPackage isKindOf: self class)
		ifFalse: [ ^ false ].
	^ self packageName = aPackage packageName
]

{ #category : 'adding' }
StPackage >> add: aDependency [
	^ dependencies add: aDependency
]

{ #category : 'converting' }
StPackage >> asDependentPackageWrapperOn: relationGraph [
	^ StDependentPackageWrapper newWith: self on: relationGraph
]

{ #category : 'converting' }
StPackage >> asPackageDependencyWrapper [
	^ StPackageDependencyWrapper newWith: self
]

{ #category : 'accessing' }
StPackage >> beIncluded [
	included := true
]

{ #category : 'accessing' }
StPackage >> beSeen [
	seen := true
]

{ #category : 'accessing' }
StPackage >> bfsParent [
	^ bfsParent
]

{ #category : 'accessing' }
StPackage >> bfsParent: aBfsParent [
	bfsParent := aBfsParent
]

{ #category : 'initialization' }
StPackage >> clearDependencies [
	dependencies := OrderedCollection new
]

{ #category : 'dependencies' }
StPackage >> compositeDependencyTo: aPackage [
	^ self dependencies detect: [ :dependency | dependency target = aPackage ] ifNone: [ nil ]
]

{ #category : 'accessing' }
StPackage >> dependencies [
	^ dependencies
]

{ #category : 'accessing' }
StPackage >> dependencies: anObject [
	dependencies := anObject
]

{ #category : 'accessing' }
StPackage >> dependenciesFrom: aClass [
	| dependenciesFrom |
	dependenciesFrom := OrderedCollection new.
	self dependencies
		do: [ :compositeDependency |
				dependenciesFrom addAll: (compositeDependency dependenciesFrom: aClass) ].
	^ dependenciesFrom
]

{ #category : 'accessing' }
StPackage >> dependenciesSize [

	^ self dependencies
			inject: 0
			into: [ :sum :dependency |
					sum + dependency numberOfDependencies
				]
]

{ #category : 'dependencies' }
StPackage >> dependenciesSizeTo: aPackage [
	| dependency |
	dependency := dependencies detect: [ :each | each target packageName = aPackage packageName ].
	^ dependency ifNotNil: [ dependency numberOfDependencies ] ifNil: [ 0 ]
]

{ #category : 'dependencies' }
StPackage >> dependenciesTo: aPackage [
	^ dependencies select: [ :each | each target packageName = aPackage ]
]

{ #category : 'dependencies' }
StPackage >> dependentPackages [
	^ self dependencies
			inject: Set new
			into: [ :dependents :each | dependents add: each target; yourself ]
]

{ #category : 'dependencies' }
StPackage >> dependentPackagesSize [
	^ dependencies size
]

{ #category : 'displaying' }
StPackage >> displayString [
	| numberOfExtension |
	numberOfExtension := self extensionDependenciesSize.
	^ String streamContents: [ :stream |
		stream
			nextPutAll: self packageName;
			nextPutAll: ' --> Dependent packages : ';
			nextPutAll: self dependentPackagesSize asString;
			nextPutAll: ' | Dependencies : ';
			nextPutAll: (self dependenciesSize - numberOfExtension) asString;
			nextPutAll: ' (+ ';
			nextPutAll: numberOfExtension asString;
			nextPutAll: ' extension dependencies)' ]
]

{ #category : 'accessing' }
StPackage >> extensionDependenciesSize [
	^ self dependencies
		inject: 0
		into: [ :sum :each | sum + each extensionDependenciesSize ]
]

{ #category : 'dependencies' }
StPackage >> extensionDependenciesSizeTo: aPackage [
	^ (self compositeDependencyTo: aPackage) extensionDependenciesSize
]

{ #category : 'comparing' }
StPackage >> hash [
	^ self packageName hash
]

{ #category : 'accessing' }
StPackage >> inStack: aBoolean [
	inStack := aBoolean
]

{ #category : 'accessing' }
StPackage >> included: anObject [
	included := anObject
]

{ #category : 'initialization' }
StPackage >> initializeWithPackage: aPackage [

	self initialize.
	self clearDependencies.
	systemPackage := aPackage.
	included := false.
	inStack := false.
	seen := false.
	tarjanIndex := -1.
	tarjanLowLink := -1
]

{ #category : 'testing' }
StPackage >> isInStack [
	^ inStack
]

{ #category : 'testing' }
StPackage >> isIncluded [
	^ included
]

{ #category : 'testing' }
StPackage >> isSeen [

	^ seen
]

{ #category : 'tarjan' }
StPackage >> isTarjanUndefined [
	^ tarjanIndex = -1
]

{ #category : 'accessing' }
StPackage >> packageName [

	^ packageName
]

{ #category : 'accessing' }
StPackage >> packageName: anObject [
	packageName := anObject
]

{ #category : 'printing' }
StPackage >> printOn: aStream [
	aStream
		nextPutAll: 'Dependencies on: ';
		nextPutAll: self packageName
]

{ #category : 'accessing' }
StPackage >> referenceDependenciesFrom: aClass [

	^ (self dependenciesFrom: aClass) select: [ :each | each isReferenceDependency ]
]

{ #category : 'removing' }
StPackage >> remove: aDependency [
	^ dependencies remove: aDependency
]

{ #category : 'dependencies' }
StPackage >> removeAllInternal [
	dependencies := dependencies reject: [ :each | each isInternal ]
]

{ #category : 'accessing' }
StPackage >> systemPackage [

	^ systemPackage
]

{ #category : 'tarjan' }
StPackage >> tarjanIndex [
	^ tarjanIndex
]

{ #category : 'tarjan' }
StPackage >> tarjanIndex: aTarjanIndex [
	tarjanIndex := aTarjanIndex
]

{ #category : 'tarjan' }
StPackage >> tarjanLowLink [
	^ tarjanLowLink
]

{ #category : 'tarjan' }
StPackage >> tarjanLowLink: aTarjanLowLink [
	tarjanLowLink := aTarjanLowLink
]
