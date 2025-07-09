"
I am a variable node for representing a temporary variable stored in a Context object that has a name attached. 
This includes  local variables and method parameters.
"
Class {
	#name : 'StInspectorNewTempNode',
	#superclass : 'StInspectorNode',
	#instVars : [
		'debugInfo',
		'tempDescriptor'
	],
	#category : 'NewTools-Inspector-Model',
	#package : 'NewTools-Inspector',
	#tag : 'Model'
}

{ #category : 'comparing' }
StInspectorNewTempNode >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ tempDescriptor = anObject name and: [ 
		  hostObject = anObject hostObject ]
]

{ #category : 'accessing' }
StInspectorNewTempNode >> children [
	^ #()
]

{ #category : 'accessing' }
StInspectorNewTempNode >> debugInfo [

	^ debugInfo
]

{ #category : 'accessing' }
StInspectorNewTempNode >> debugInfo: anObject [

	debugInfo := anObject
]

{ #category : 'comparing' }
StInspectorNewTempNode >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ tempDescriptor hash bitXor: (hostObject hash)
]

{ #category : 'accessing' }
StInspectorNewTempNode >> hostObject: aContext [

	super hostObject: aContext.
	debugInfo := aContext method debugInfo.
]

{ #category : 'accessing' }
StInspectorNewTempNode >> isArgumentVariable [

	^ tempDescriptor second
]

{ #category : 'accessing' }
StInspectorNewTempNode >> isTempVariable [

	^ self isArgumentVariable not
]

{ #category : 'accessing' }
StInspectorNewTempNode >> key [
	^ tempDescriptor first
]

{ #category : 'accessing' }
StInspectorNewTempNode >> rawValue [
	"Answer the object value of this object variable (slot, indexed attribute, computed value)."

	| scope |
	scope := (debugInfo debugScopeAt: (self hostObject executedPC max: self hostObject method initialPC)).
	^ scope readVariableNamed: tempDescriptor first at: self hostObject
]

{ #category : 'accessing' }
StInspectorNewTempNode >> tempDescriptor [

	^ tempDescriptor
]

{ #category : 'accessing' }
StInspectorNewTempNode >> tempDescriptor: anObject [

	tempDescriptor := anObject
]

{ #category : 'accessing' }
StInspectorNewTempNode >> variableTag [

	^ 'temp. var'
]
