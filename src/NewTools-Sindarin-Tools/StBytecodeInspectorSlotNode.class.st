Class {
	#name : 'StBytecodeInspectorSlotNode',
	#superclass : 'StInspectorSlotNode',
	#category : 'NewTools-Sindarin-Tools-Model',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Model'
}

{ #category : 'accessing' }
StBytecodeInspectorSlotNode >> key [
	^ 'rcvr: ' , (self slot index - 1) asString, ' [' , super key , ']'
]
