"
I am the default ED Debugging interface.
I return a set of CmCommands exposing my interface.
"
Class {
	#name : #EDDebuggingAPI,
	#superclass : #Object,
	#instVars : [
		'session',
		'debugger'
	],
	#category : #'Emergency-Debugger'
}

{ #category : #'API - Revert' }
EDDebuggingAPI >> changeRecordsForMethod: aRgMethodHistoricalRingDefinition [
	^ SourceFiles
		changeRecordsFrom: aRgMethodHistoricalRingDefinition sourcePointer
		className: aRgMethodHistoricalRingDefinition instanceSideParentName
		isMeta: aRgMethodHistoricalRingDefinition isMetaSide
]

{ #category : #accessing }
EDDebuggingAPI >> debugger: anObject [
	debugger := anObject
]

{ #category : #'API - Revert' }
EDDebuggingAPI >> revert: method to: aChangeRecord [
	"Reverts the given method to the given change record"

	method asRingDefinition realClass
		compile: aChangeRecord sourceCode
		classified: aChangeRecord category
		withStamp: aChangeRecord stamp
		notifying: nil
]

{ #category : #'API - Revert' }
EDDebuggingAPI >> rgMethodHistorical: aMethod [
	^ aMethod asHistoricalRingDefinition
]

{ #category : #accessing }
EDDebuggingAPI >> session: anObject [
	session := anObject
]

{ #category : #'API - Revert' }
EDDebuggingAPI >> versionsForMethod: aMethod [
	^ (self changeRecordsForMethod: (self rgMethodHistorical: aMethod))
		collectWithIndex: [ :c :i | 
			| rg |
			rg := c asRingDefinition.
			rg annotationNamed: #versionIndex put: i ]
]