"
UI merging SpecTreeModel package dependencies and browser
"
Class {
	#name : 'StCycleDetectionPresenter',
	#superclass : 'StPackageAnalyzerPresenter',
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'examples' }
StCycleDetectionPresenter class >> collections [
	^ (self onPackagesMatch: '*Collections*')
		open
]

{ #category : 'instance creation' }
StCycleDetectionPresenter class >> onPackagesMatch: match [
	^ (self onPackagesNamed:	self systemPackages)
		open
]

{ #category : 'instance creation' }
StCycleDetectionPresenter class >> onPackagesNamed: aCollection [
	^ self on: (StCycleDetectionTreePresenter onPackagesNamed: aCollection)
]

{ #category : 'examples' }
StCycleDetectionPresenter class >> system [
	^ self on: StCycleDetectionTreePresenter system
]

{ #category : 'initialization - filter' }
StCycleDetectionPresenter >> initializeCycleDetectionTreeModelWith: aCollection [

	self initializeWithSystemCycles.
	self dependenciesPresenter filterWithPackages: aCollection
]

{ #category : 'initialization - filter' }
StCycleDetectionPresenter >> initializeWithSystemCycles [
	self model: StCycleDetectionTreePresenter system
]

{ #category : 'update' }
StCycleDetectionPresenter >> updateWithFilter: aCollectionOfPDPackages [
	self dependenciesPresenter filterWithPackages: aCollectionOfPDPackages
]
