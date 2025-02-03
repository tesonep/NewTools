Class {
	#name : 'UnknownBytecode',
	#superclass : 'Error',
	#instVars : [
		'pc',
		'bytecode'
	],
	#category : 'NewTools-Debugger-Morphic',
	#package : 'NewTools-Debugger-Morphic'
}

{ #category : 'accessing' }
UnknownBytecode >> bytecode [
	^ bytecode
]

{ #category : 'accessing' }
UnknownBytecode >> bytecode: aValue [

	bytecode := aValue
]

{ #category : 'accessing' }
UnknownBytecode >> pc: aValue [

	pc := aValue
]
