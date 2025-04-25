Class {
	#name : 'StTestSettingChangeReactivePresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'changedSetting'
	],
	#category : 'NewTools-Core-Tests-Application',
	#package : 'NewTools-Core-Tests',
	#tag : 'Application'
}

{ #category : 'accessing' }
StTestSettingChangeReactivePresenter >> changedSetting [

	^ changedSetting
]

{ #category : 'layout' }
StTestSettingChangeReactivePresenter >> defaultLayout [
	^SpBoxLayout new
]

{ #category : 'initialization' }
StTestSettingChangeReactivePresenter >> initialize [

	super initialize.
	self announcer
		when: CodeShowLineNumbersChanged
		send: #settingChanged:
		to: self
]

{ #category : 'as yet unclassified' }
StTestSettingChangeReactivePresenter >> settingChanged: aSettingChangedAnnouncement [

	changedSetting := aSettingChangedAnnouncement
]
