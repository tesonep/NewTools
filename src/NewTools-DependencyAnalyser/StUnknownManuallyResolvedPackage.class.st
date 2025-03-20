"
I am a Warning raised to the user if the list of manually resolved dependencies contains a package that does not exist in the system.
"
Class {
	#name : 'StUnknownManuallyResolvedPackage',
	#superclass : 'Warning',
	#instVars : [
		'package'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'signalling' }
StUnknownManuallyResolvedPackage class >> signalOn: aPackageName [

	^ self new
		  package: aPackageName;
		  signal
]

{ #category : 'accessing' }
StUnknownManuallyResolvedPackage >> messageText [
	^ messageText
		ifNil: [ package , ' dependency declared in the package Manifest as manuallyResolvedDependencies not detected in the system!' ]
]

{ #category : 'accessing' }
StUnknownManuallyResolvedPackage >> package [

	^ package
]

{ #category : 'accessing' }
StUnknownManuallyResolvedPackage >> package: anObject [

	package := anObject
]
