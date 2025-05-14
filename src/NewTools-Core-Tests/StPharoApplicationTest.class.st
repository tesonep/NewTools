"
A StPharoApplicationTest is a test class for testing the behavior of StPharoApplication
"
Class {
	#name : 'StPharoApplicationTest',
	#superclass : 'TestCase',
	#category : 'NewTools-Core-Tests-Application',
	#package : 'NewTools-Core-Tests',
	#tag : 'Application'
}

{ #category : 'tests' }
StPharoApplicationTest >> testSettingChangesSubscription [

	| app presenter window oldSetting |
	app := StPharoApplication basicNew.
	app subscribeToSettingsAnnouncements.
	presenter := StTestSettingChangeReactivePresenter new.
	presenter application: app.
	window := SpWindowPresenter presenter: presenter.
	app registerWindow: window.

	self assert: presenter changedSetting isNil.

	oldSetting := StPharoSettings codeShowLineNumbers.
	StPharoSettings codeShowLineNumbers: oldSetting.

	self
		assert: presenter changedSetting class
		identicalTo: SpCodeShowLineNumbersChanged
]

{ #category : 'tests' }
StPharoApplicationTest >> testToolRegistration [
	
	| app |
	app := StPharoApplication new.
	app register: SpPresenter as: #toto.
	
	self assert: (app toolNamed: #toto) equals: SpPresenter
]

{ #category : 'tests' }
StPharoApplicationTest >> testToolRegistrationIsFailing [
	
	| app |
	app := StPharoApplication new.
	app register: SpPresenter as: #toto.
	
	self should: [ app toolNamed: #toto2 ] raise: Error
]
