"
Welcome user interface to browse dependencies packages. Availaible via tools menu.

self new openWithSpec
"
Class {
	#name : 'StWelcomePresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'choosePresenter',
		'browseDependenciesButton'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Core',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Core'
}

{ #category : 'accessing' }
StWelcomePresenter class >> defaultPreferredExtent [ 
	^ (800@800)
]

{ #category : 'world menu' }
StWelcomePresenter class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #PackageDependencies)
		order: 2;
		parent: #Packaging;
		label: 'Dependency Analyser';
		iconName: #package;
		help: 'Analyze dependencies between different packages in the image.';
		action: [ self new open ]
]

{ #category : 'layout' }
StWelcomePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: choosePresenter;
		add: browseDependenciesButton expand: false;
		yourself
]

{ #category : 'initialization' }
StWelcomePresenter >> initializePresenters [

	choosePresenter := SpChooserPresenter new
		sourceItems: self packageOrganizer packages;
		displayBlock: [ :aPackage | aPackage name ];
		yourself.

	browseDependenciesButton := self newButton
		help: 'Open the package dependencies analysis';
		label: 'Browse dependencies';
		icon: (self iconNamed: #package);
		action: [ self selectedPackages ifNotEmpty: [ self openDependencyAnalyzer ] ]
		yourself
]

{ #category : 'action' }
StWelcomePresenter >> openDependencyAnalyzer [
	(StPackageDependenciesPresenter onPackagesNamed: self selectedPackageNames) open.
	choosePresenter delete
]

{ #category : 'accessing' }
StWelcomePresenter >> selectedPackageNames [
	^ self selectedPackages collect: [ :each | each name ]
]

{ #category : 'accessing' }
StWelcomePresenter >> selectedPackages [
	^ choosePresenter chosenItems
]

{ #category : 'accessing' }
StWelcomePresenter >> windowTitle [

	^ 'Package Dependencies Browser'
]
