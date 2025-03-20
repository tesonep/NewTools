Class {
	#name : 'StClassToDependencyNode',
	#superclass : 'StClassNode',
	#instVars : [
		'package'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'procotol' }
StClassToDependencyNode >> childNodeClassFor: anItem [
	 ^ anItem nodeClass
]

{ #category : 'accessing' }
StClassToDependencyNode >> children [
	^ self dependencies
]

{ #category : 'accessing' }
StClassToDependencyNode >> dependencies [
	^ self package dependenciesFrom: self content
]

{ #category : 'accessing' }
StClassToDependencyNode >> hasChildren [
	^ self dependencies isNotEmpty
]

{ #category : 'accessing' }
StClassToDependencyNode >> icon [
	^ self iconNamed: #confirm
]

{ #category : 'accessing' }
StClassToDependencyNode >> package [
	^ package
]

{ #category : 'accessing' }
StClassToDependencyNode >> package: anObject [
	package := anObject
]

{ #category : 'browse-nautilus' }
StClassToDependencyNode >> spawnNewBrowser [
	self browseClass: self content browse
]
