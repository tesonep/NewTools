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
