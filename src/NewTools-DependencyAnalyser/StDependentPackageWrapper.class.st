"
Other wrapper for dependent package (use in TreePresenter). Useful in reverse analysis.
"
Class {
	#name : 'StDependentPackageWrapper',
	#superclass : 'Object',
	#instVars : [
		'pdPackage',
		'relationGraph'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StDependentPackageWrapper class >> newWith: aPackage on: relationGraph [
	^ self new initializeFrom: aPackage on: relationGraph
]

{ #category : 'comparing' }
StDependentPackageWrapper >> <= other [
	^ self daPackage <= other daPackage
]

{ #category : 'accessing' }
StDependentPackageWrapper >> daPackage [
	^ pdPackage
]

{ #category : 'accessing' }
StDependentPackageWrapper >> daPackage: anObject [
	pdPackage := anObject
]

{ #category : 'accessing' }
StDependentPackageWrapper >> dependenciesSize [
	| usersOf |
	usersOf := self usersOfPackage.
	^ usersOf
			 inject: 0
			 into: [ :sum :each | sum + (each dependenciesSizeTo: self daPackage) ]
]

{ #category : 'accessing' }
StDependentPackageWrapper >> extensionDependenciesSize [
	| usersOf |
	usersOf := self usersOfPackage.
	^ usersOf
			inject: 0
			into: [ :sum :each | sum + (each extensionDependenciesSizeTo: self daPackage) ]
]

{ #category : 'initialization' }
StDependentPackageWrapper >> initializeFrom: aPackage on: aRelationGraph [
	pdPackage := aPackage.
	relationGraph :=aRelationGraph
]

{ #category : 'accessing' }
StDependentPackageWrapper >> packageName [
	^ self daPackage packageName
]

{ #category : 'printing' }
StDependentPackageWrapper >> printOn: aStream [
	| numberOfExtension |
	numberOfExtension := self extensionDependenciesSize.
	aStream
		nextPutAll: self packageName;
		nextPutAll: ' <-- Users : ';
		print: self usersOfPackageSize;
		nextPutAll: ' package(s) | ';
		nextPutAll: 'Dependencies : ';
		print: ((self dependenciesSize) - numberOfExtension);
		nextPutAll: ' (+ ';
		print: numberOfExtension;
		nextPutAll: ' extension dependencies ';
		nextPutAll: ')'
]

{ #category : 'accessing' }
StDependentPackageWrapper >> relationGraph [
	^ relationGraph
]

{ #category : 'accessing' }
StDependentPackageWrapper >> relationGraph: anObject [
	relationGraph := anObject
]

{ #category : 'accessing' }
StDependentPackageWrapper >> systemPackage [
	^ pdPackage systemPackage
]

{ #category : 'accessing' }
StDependentPackageWrapper >> usersOfPackage [
	^ relationGraph usersOf: pdPackage
]

{ #category : 'accessing' }
StDependentPackageWrapper >> usersOfPackageSize [
	^ self usersOfPackage size
]
