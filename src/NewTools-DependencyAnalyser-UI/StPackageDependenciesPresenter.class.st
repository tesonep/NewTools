"
UI merging SpecTreeModel cycles and browser
"
Class {
	#name : 'StPackageDependenciesPresenter',
	#superclass : 'StPackageAnalyzerPresenter',
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'examples' }
StPackageDependenciesPresenter class >> collections [
	^ (self onPackagesMatch: '*Collections*') open
]

{ #category : 'instance creation' }
StPackageDependenciesPresenter class >> onPackagesMatch: match [
	^ (self onPackagesNamed:
			(self packageOrganizer packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) )
]

{ #category : 'examples' }
StPackageDependenciesPresenter class >> system [
	^ (self onPackagesNamed: self systemPackages) open
]

{ #category : 'specs' }
StPackageDependenciesPresenter class >> title [

	^ 'Dependecy Analyser'
]

{ #category : 'initialization' }
StPackageDependenciesPresenter >> initializeWithRelationGraph: aRelationGraph [
	self model: (StReverseTreePresenter onRelationGraph: aRelationGraph).
	"self buildandAddAllMorph "
]
