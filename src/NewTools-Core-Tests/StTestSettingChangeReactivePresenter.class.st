"
I'm a test presenter for testing how the StPresenters react to settings changes announcements from their applications.
"
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
		when: SpCodeShowLineNumbersChanged
		send: #settingChanged:
		to: self
]

{ #category : 'accessing' }
StTestSettingChangeReactivePresenter >> settingChanged: aSettingChangedAnnouncement [

	changedSetting := aSettingChangedAnnouncement
]
