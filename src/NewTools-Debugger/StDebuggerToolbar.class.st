Class {
	#name : 'StDebuggerToolbar',
	#superclass : 'Object',
	#instVars : [
		'commandsGroup',
		'owner',
		'toolbarPresenter'
	],
	#category : 'NewTools-Debugger-Model',
	#package : 'NewTools-Debugger',
	#tag : 'Model'
}

{ #category : 'instance creation' }
StDebuggerToolbar class >> on: aStPresenter [

	^ self new
		  owner: aStPresenter;
		  build;
		  yourself
]

{ #category : 'settings' }
StDebuggerToolbar class >> toolbarLayoutCompact [

	^ StDebuggerSettings toolbarLayout
	  = StDebuggerSettings toolbarLayoutCompact
]

{ #category : 'instance creation' }
StDebuggerToolbar class >> toolbarOn: aStPresenter [

	^ (self toolbarLayoutCompact
		   ifTrue: [ StDebuggerCompactToolbar ]
		   ifFalse: [ StDebuggerStandardToolbar ]) on: aStPresenter
]

{ #category : 'building' }
StDebuggerToolbar >> build [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
StDebuggerToolbar >> commandsGroup: anObject [

	commandsGroup := anObject
]

{ #category : 'accessing' }
StDebuggerToolbar >> owner: aStPresenter [

	owner := aStPresenter
]

{ #category : 'accessing' }
StDebuggerToolbar >> toolbarPresenter [

	^ toolbarPresenter
]

{ #category : 'accessing' }
StDebuggerToolbar >> toolbarPresenter: anObject [

	toolbarPresenter := anObject
]

{ #category : 'updating' }
StDebuggerToolbar >> updateWith: aCommandGroup [

	commandsGroup := aCommandGroup
]
