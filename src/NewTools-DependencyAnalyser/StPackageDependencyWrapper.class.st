"
Wrapper for dependent package (use in TreePresenter)
"
Class {
	#name : 'StPackageDependencyWrapper',
	#superclass : 'Object',
	#instVars : [
		'daPackage'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StPackageDependencyWrapper class >> newWith: aPackage [
	^ self new initializeFrom: aPackage
]

{ #category : 'comparing' }
StPackageDependencyWrapper >> <= other [
	^ self daPackage <= other daPackage
]

{ #category : 'accessing' }
StPackageDependencyWrapper >> daPackage [
	^ daPackage
]

{ #category : 'accessing' }
StPackageDependencyWrapper >> daPackage: anObject [
	daPackage := anObject
]

{ #category : 'initialization' }
StPackageDependencyWrapper >> initializeFrom: aPackage [
	super initialize.
	self daPackage: aPackage
]

{ #category : 'accessing' }
StPackageDependencyWrapper >> packageName [
	^ daPackage packageName
]

{ #category : 'printing' }
StPackageDependencyWrapper >> printOn: aStream [
	aStream nextPutAll: self packageName
]

{ #category : 'accessing' }
StPackageDependencyWrapper >> systemPackage [

	^ daPackage systemPackage
]
