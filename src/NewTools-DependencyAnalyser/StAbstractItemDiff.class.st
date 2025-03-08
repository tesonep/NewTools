"
A PDAbstractItemDiff is a object which represent an item who added/modified/removed from an old analysis.
"
Class {
	#name : 'StAbstractItemDiff',
	#superclass : 'Object',
	#instVars : [
		'new',
		'underteminate',
		'content',
		'diff',
		'removed'
	],
	#category : 'NewTools-DependencyAnalyser-Diff',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Diff'
}

{ #category : 'testing' }
StAbstractItemDiff class >> isAbstract [

	^self == StAbstractItemDiff
]

{ #category : 'instance creation' }
StAbstractItemDiff class >> newWith: aContent [
	^ (self new)
		content: aContent;
		yourself
]

{ #category : 'actions' }
StAbstractItemDiff >> beNew [
	new := true
]

{ #category : 'actions' }
StAbstractItemDiff >> beRemoved [
	removed := true
]

{ #category : 'testing' }
StAbstractItemDiff >> beUnderteminate [
	underteminate := true
]

{ #category : 'testing' }
StAbstractItemDiff >> canBeDisplay [
	^ (self isNew or: [ self isRemoved ]) or: [ self hasChanged ]
]

{ #category : 'accessing' }
StAbstractItemDiff >> content [
	 ^ content
]

{ #category : 'accessing' }
StAbstractItemDiff >> content: aContent [
	content := aContent
]

{ #category : 'accessing' }
StAbstractItemDiff >> diff [
	^ diff
]

{ #category : 'accessing' }
StAbstractItemDiff >> diff: anObject [
	diff := anObject
]

{ #category : 'testing' }
StAbstractItemDiff >> hasChanged [
	self subclassResponsibility
]

{ #category : 'initialization' }
StAbstractItemDiff >> initialize [
	new := false.
	removed := false.
	underteminate := false
]

{ #category : 'testing' }
StAbstractItemDiff >> isNew [
	^ new
]

{ #category : 'testing' }
StAbstractItemDiff >> isRemoved [
	^ removed
]

{ #category : 'testing' }
StAbstractItemDiff >> isUnderteminate [
	 ^ underteminate
]

{ #category : 'printing' }
StAbstractItemDiff >> printOn: aStream [
	self subclassResponsibility
]
