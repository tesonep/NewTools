Class {
	#name : 'StSettingDetailPresenter',
	#superclass : 'StSettingsAbstractPresenter',
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'settingPresenter'
	],
	#category : 'NewTools-SettingsBrowser-UI',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'UI'
}

{ #category : 'layout' }
StSettingDetailPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: settingPresenter;
		yourself
]

{ #category : 'initialization' }
StSettingDetailPresenter >> initializePresenters [

	"this will be replaced when received a new setting"
	settingPresenter := self newLabel
]

{ #category : 'initialization' }
StSettingDetailPresenter >> newSettingPresenter: aNode [
	
	^ self newSettingPresenter: aNode children: aNode allChildren
]

{ #category : 'initialization' }
StSettingDetailPresenter >> newSettingPresenter: aNode children: children [
	| general groups newSettingPresenter |

	general := children reject: #hasChildren.
	groups := general size ~= children size 
		ifTrue: [ children select: #hasChildren ]
		ifFalse: [ nil ].

	newSettingPresenter := (groups isNotNil and: [ aNode level > 1 ])
		ifTrue: [ 
			self newPresenter
				layout: (SpBoxLayout newVertical
					vAlignStart;
					in: [ :this | 
						general ifNotEmpty: [
							this add: (self newSettingSectionPresenter: self model children: general) ].
						groups do: [ :each | 
							"recursive, because we don't know :P"
							this add: (self newSettingPresenter: each) ] ];
					yourself);
				yourself ]
		ifFalse: [
			self newSettingSectionPresenter: aNode children: general ].

	^ newSettingPresenter
]

{ #category : 'Protocol (initialization) - 5 selector(s)' }
StSettingDetailPresenter >> newSettingSectionPresenter: aNode children: aCollection [
	| newSettingPresenter |

	newSettingPresenter := self newPresenter 
		addStyle: 'settingPanel';
		layout: (SpBoxLayout newTopToBottom
			vAlignStart;
			yourself);
		yourself.
		
	aCollection ifNotEmpty: [
		"Add a header"
		newSettingPresenter layout add: (self newPresenter
			addStyle: 'settingHeader';
			layout: (SpBoxLayout newHorizontal 
				add: (aNode asPresenterOn: self);
				yourself);
			yourself).
		"now all settings"
		(aCollection sorted: #order ascending, #name ascending) do: [ :eachNode |
			| presenter |
			presenter := eachNode asPresenterOn: self.
			newSettingPresenter layout add: presenter ] ].
	
	^ newSettingPresenter
]

{ #category : 'initialization' }
StSettingDetailPresenter >> updatePresenter [
	| newSettingPresenter children general groups |

	self model ifNil: [ ^ self ].
	
	newSettingPresenter := self newPresenter 
		layout: (SpScrollableLayout with: (self newSettingPresenter: self model));
		yourself.

	self layout 
		replace: settingPresenter
		with: newSettingPresenter.
		
	settingPresenter := newSettingPresenter
]
