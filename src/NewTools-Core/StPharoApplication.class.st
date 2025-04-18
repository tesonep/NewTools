"
The application for the Pharo IDE.
"
Class {
	#name : 'StPharoApplication',
	#superclass : 'SpApplication',
	#classVars : [
		'Current'
	],
	#category : 'NewTools-Core-Application',
	#package : 'NewTools-Core',
	#tag : 'Application'
}

{ #category : 'instance creation' }
StPharoApplication class >> current [ 
	
	^ Current ifNil: [ Current := self new ]
]

{ #category : 'class initialization' }
StPharoApplication class >> initialize [ 

	SessionManager default registerToolClassNamed: self name
]

{ #category : 'system startup' }
StPharoApplication class >> shutDown: quitting [

	Current ifNil: [ ^ self ].
	Current shutDown: quitting
]

{ #category : 'system startup' }
StPharoApplication class >> startUp: resuming [

	Current ifNil: [ ^ self ].
	Current startUp: resuming
]

{ #category : 'private' }
StPharoApplication class >> use: application during: aBlock [ 
	| oldCurrent |
	
	oldCurrent := Current.
	Current := application.
	^ aBlock ensure: [ Current := oldCurrent ]
]

{ #category : 'accessing - resources' }
StPharoApplication >> defaultWindowExtent [
	
	self flag: #TODO. "Replace this with a real real estate"
	^ 800@600
]

{ #category : 'showing' }
StPharoApplication >> defaultWindowPresenterClass [
	
	^ StWindowPresenter
]

{ #category : 'initialization' }
StPharoApplication >> initialize [

	super initialize.
	self initializeConfiguration
]

{ #category : 'initialization' }
StPharoApplication >> initializeConfiguration [

	self resetConfiguration.
	self class codeSupportAnnouncer weak when: UIThemeChanged send: #resetConfiguration to: self
]

{ #category : 'private - factory' }
StPharoApplication >> newIconProvider [

	^ StPharoDefaultIconProvider new
]

{ #category : 'tool management' }
StPharoApplication >> register: aPresenterClass as: aNameSelector [
	"Register the presenter class of a tool with a given nickname"
	
	self tools register: aPresenterClass as: aNameSelector
]

{ #category : 'private - running' }
StPharoApplication >> resetBackend [
	| backendName |
	
	backendName := backend 
		ifNil: [ self class defaultBackendName ] 
		ifNotNil: [ backend name ].
	self useBackend: backendName.
]

{ #category : 'initialization' }
StPharoApplication >> resetConfiguration [
	
	self configuration reset
]

{ #category : 'running' }
StPharoApplication >> run [ 

	Current ifNotNil: [ Current closeAllWindows ].
	super run. 
	Current := self
]

{ #category : 'system startup' }
StPharoApplication >> shutDown: quitting [
]

{ #category : 'system startup' }
StPharoApplication >> startUp: resuming [

	self resetConfiguration.
	self resetBackend.
]

{ #category : 'tool management' }
StPharoApplication >> toolNamed: aName [

	^ self tools toolNamed: aName
]

{ #category : 'settings' }
StPharoApplication >> toolbarDisplayMode [

	^ StPharoSettings toolbarDisplayMode
]

{ #category : 'tool management' }
StPharoApplication >> tools [

	^ Smalltalk tools
]

{ #category : 'tool management' }
StPharoApplication >> unregisterToolWithRole: aName [

	self tools unregisterToolWithRole: aName
]
