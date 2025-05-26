Class {
	#name : 'StSindarinDebuggerScriptSaver',
	#superclass : 'Object',
	#classInstVars : [
		'scripts'
	],
	#category : 'NewTools-Sindarin-Tools-Model',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Model'
}

{ #category : 'accessing' }
StSindarinDebuggerScriptSaver class >> clearScripts [
	<script>
	scripts := Dictionary new.
]

{ #category : 'accessing' }
StSindarinDebuggerScriptSaver class >> loadScript: aString [
	^ scripts at: aString.
	
]

{ #category : 'accessing' }
StSindarinDebuggerScriptSaver class >> saveScript: aStringKey code: aStringValue [
	
	scripts add: aStringKey -> aStringValue.
]

{ #category : 'accessing' }
StSindarinDebuggerScriptSaver class >> scripts [
	^ scripts ifNil: [ scripts := Dictionary new]
]

{ #category : 'accessing' }
StSindarinDebuggerScriptSaver class >> scriptsNames [
   ^ self scripts keys
]
