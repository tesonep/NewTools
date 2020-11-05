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

{ #category : #actions }
StPackageChooserPresenter >> addAll [
]

{ #category : #actions }
StPackageChooserPresenter >> addSelected [
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
			add: (selectedPackagesList := self newList);
			yourself);
		add: (actionBar := SpBoxLayout newLeftToRight hAlignEnd) expand: false;
		yourself).

	packageList display: [ :each | each packageName ].
		
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

	^ RPackageOrganizer default packages
]

{ #category : #actions }
StPackageChooserPresenter >> removeAll [
]

{ #category : #actions }
StPackageChooserPresenter >> removeSelected [
]

{ #category : #initialization }
StPackageChooserPresenter >> updatePresenter [

	packageList items: self packages
]
