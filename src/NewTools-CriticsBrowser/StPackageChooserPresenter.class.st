Class {
	#name : #StPackageChooserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'packageList',
		'selectedPackagesList',
		'buttonBar',
		'actionBar'
	],
	#category : #'NewTools-CriticsBrowser'
}

{ #category : #example }
StPackageChooserPresenter class >> example [

	self new openWithSpec
]

{ #category : #actions }
StPackageChooserPresenter >> addAll [

	selectedPackagesList items: 
		(selectedPackagesList items, 
		(packageList items sorted: #packageName ascending)).
	packageList items: #().
	packageList selectedItems: #()
	
]

{ #category : #actions }
StPackageChooserPresenter >> addSelected [

	selectedPackagesList items: 
		(selectedPackagesList items, 
		(packageList selectedItems sorted: #packageName ascending)).
	packageList items: ((packageList items \ packageList selectedItems) sorted: #packageName ascending).
	packageList selectedItems: #()
]

{ #category : #initialization }
StPackageChooserPresenter >> initializePresenters [
	<script: 'self new openWithSpec'>

	self layout: (SpBoxLayout newTopToBottom
		spacing: 5;
		add: (SpPanedLayout newLeftToRight
			add: (SpBoxLayout newLeftToRight
				spacing: 5;
				add: (packageList := (self instantiate: SpFilteringSelectableListPresenter));
				add: (buttonBar := SpBoxLayout newTopToBottom) expand: false;
				yourself);
			add: (selectedPackagesList := (self instantiate: SpFilteringSelectableListPresenter));
			yourself);
		add: (actionBar := SpBoxLayout newLeftToRight hAlignEnd) expand: false;
		yourself).

	packageList display: [ :each | each packageName ].
	selectedPackagesList display: [ :each | each packageName ].
		
	buttonBar 
		add: (self newButton
				addStyle: 'small';
				label: '>';
				action: [ self addSelected ];
				yourself)
			expand: false;
		add: (self newButton
				addStyle: 'small';
				label: '>>';
				action: [ self addAll ];
				yourself)
			expand: false;
		add: (self newButton
				addStyle: 'small';
				label: '<';
				action: [ self removeSelected ];
				yourself)
			expand: false;
		add: (self newButton
				addStyle: 'small';
				label: '<<';
				action: [ self removeAll ];
				yourself)
			expand: false.
	
	actionBar
		add: (self newButton
			label: 'Accept';
			yourself).
]

{ #category : #initialization }
StPackageChooserPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Choose Packages';
		initialExtent: 700@500

]

{ #category : #accessing }
StPackageChooserPresenter >> packages [

	^ RPackageOrganizer default packages sorted: #packageName ascending
]

{ #category : #actions }
StPackageChooserPresenter >> removeAll [

	selectedPackagesList items: #().
	packageList items: self packages
]

{ #category : #actions }
StPackageChooserPresenter >> removeSelected [

	packageList items: ((packageList items, packageList selectedItems) sorted: #packageName ascending).
	selectedPackagesList items: ((selectedPackagesList items \ selectedPackagesList selectedItems)  sorted: #packageName ascending).
	selectedPackagesList selectedItems: #()
]

{ #category : #initialization }
StPackageChooserPresenter >> updatePresenter [

	packageList items: self packages
]
