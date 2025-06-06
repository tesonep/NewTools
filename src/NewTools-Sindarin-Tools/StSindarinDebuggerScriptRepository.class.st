Class {
	#name : 'StSindarinDebuggerScriptRepository',
	#superclass : 'Object',
	#classInstVars : [
		'scripts'
	],
	#category : 'NewTools-Sindarin-Tools-Model',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Model'
}

{ #category : 'accessing' }
StSindarinDebuggerScriptRepository class >> clearScripts [
	<script>
	scripts := Dictionary new.
]

{ #category : 'accessing' }
StSindarinDebuggerScriptRepository class >> loadScript: aString [
	^ self scripts at: aString ifAbsent: nil.
	
]

{ #category : 'accessing' }
StSindarinDebuggerScriptRepository class >> saveScript: aStringKey code: aStringValue [
	
	self scripts add: aStringKey -> aStringValue.
]

{ #category : 'accessing' }
StSindarinDebuggerScriptRepository class >> scripts [
	^ scripts ifNil: [ scripts := Dictionary new]
]

{ #category : 'accessing' }
StSindarinDebuggerScriptRepository class >> scriptsNames [
   ^ self scripts keys
]
