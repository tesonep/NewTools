"
A PDCycleNode is used to display a cycle in a tree.
"
Class {
	#name : 'StCycleNode',
	#superclass : 'StNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StCycleNode >> childNodeClassFor: anItem [
	^ StPackageUnderAnalysisNode
]

{ #category : 'accessing' }
StCycleNode >> icon [
	^ self iconNamed: #refresh
]

{ #category : 'accessing' }
StCycleNode >> isCycleNode [
	^ true
]

{ #category : 'browse-nautilus' }
StCycleNode >> selectInBrowser [
	"we cannot browse a cycle in browser"
	^ self
]
