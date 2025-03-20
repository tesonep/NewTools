"
A PDPackageAnalyzerDiffTreeModel is to watch what are the difference between two analysis of dependencies.
"
Class {
	#name : 'StPackageAnalyzerDiffTreePresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'treeDiff',
		'packageRelationGraphDiff'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'instance creation' }
StPackageAnalyzerDiffTreePresenter class >> newWith: oldRelationGraph on: newRelationGraph [
	^ self new
		initializeWith: oldRelationGraph on: newRelationGraph;
		yourself
]

{ #category : 'specs' }
StPackageAnalyzerDiffTreePresenter class >> title [

	^ 'Package Dependencies Analysis Diff'
]

{ #category : 'initialization' }
StPackageAnalyzerDiffTreePresenter >> buildRoots [
	self treeDiff roots: packageRelationGraphDiff packagesDiffToDisplay.
	self treeDiff whenBuiltDo: [ treeDiff children: [ :item | StPackageItemDiffNode new content: item ] ]
]

{ #category : 'specs' }
StPackageAnalyzerDiffTreePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: #treeDiff;
		yourself
]

{ #category : 'protocol' }
StPackageAnalyzerDiffTreePresenter >> extent [
	^ 900@900
]

{ #category : 'initialization' }
StPackageAnalyzerDiffTreePresenter >> initializePresenters [

	treeDiff := self newTree
]

{ #category : 'initialization' }
StPackageAnalyzerDiffTreePresenter >> initializeWith: oldRelationGraph on: newRelationGraph [
	packageRelationGraphDiff := StPackageRelationGraphDiff new
		oldRelationGraph: oldRelationGraph;
		newRelationGraph: newRelationGraph.
	packageRelationGraphDiff make.

	self buildRoots
]

{ #category : 'accessing' }
StPackageAnalyzerDiffTreePresenter >> treeDiff [
	^ treeDiff
]
