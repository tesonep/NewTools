"
A DAPackageAnalyzerWindow class is an abstract presenter.
It defines a Spec Tree (package dependencies or cycles) as well as a system browser on the right side.

The main feature is to browse automatically in the browser when you click on a node (package or dependency).

"
Class {
	#name : 'StPackageAnalyzerPresenter',
	#superclass : 'StPresenterWithModel',
	#instVars : [
		'browserWrapper'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'testing' }
StPackageAnalyzerPresenter class >> defaultPreferredExtent [ 

	^ 1500@800
]

{ #category : 'testing' }
StPackageAnalyzerPresenter class >> isAbstract [

	^ self == StPackageAnalyzerPresenter
]

{ #category : 'instance creation' }
StPackageAnalyzerPresenter class >> onPackagesNamed: aCollection [
	^ self on: (StDependencyTreePresenter onPackagesNamed: aCollection)
]

{ #category : 'accessing' }
StPackageAnalyzerPresenter class >> selectedPackagesFrom: aBuilder [
	| target selectedPackages |
	target := aBuilder model.
	selectedPackages := target selectedPackages collect: [ :rpackage | rpackage packageName asString ].
	^ selectedPackages
]

{ #category : 'examples' }
StPackageAnalyzerPresenter class >> systemPackages [
	^ self packageOrganizer packages collect: [ :package | package packageName asString ]
]

{ #category : 'accessing' }
StPackageAnalyzerPresenter >> browserWindow [

	^ self model browser
]

{ #category : 'morphic ui' }
StPackageAnalyzerPresenter >> defaultLabel [
	^ 'Package Dependencies Analysis'
]

{ #category : 'layout' }
StPackageAnalyzerPresenter >> defaultLayout [
	^ SpPanedLayout newHorizontal
		add: self model;
		add: browserWrapper;
		positionOfSlider: 0.3;
		yourself
]

{ #category : 'open/close' }
StPackageAnalyzerPresenter >> delete [
	self dependenciesPresenter close.
	^ super delete
]

{ #category : 'accessing' }
StPackageAnalyzerPresenter >> dependenciesPresenter [
	^ self model
]

{ #category : 'initialization' }
StPackageAnalyzerPresenter >> initializePresenters [

	browserWrapper := self newMorph
		morph: self browserWindow
]
