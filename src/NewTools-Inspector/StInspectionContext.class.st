"
An object to control the visibility and properties of inspections. 
It will be passed to the objects defining the inspections, in case they implement the method defined in `StInspectionContext>>#contextMethodSelector`.

If I fail to create a presentation, I provide a debug presentation instead.

## Example
If you define a method `Object>>#inspectionMeta`, you can define a context method `Object>>#inspectionMetaContext:`.
"
Class {
	#name : 'StInspectionContext',
	#superclass : 'Object',
	#instVars : [
		'inspectedObject',
		'active',
		'title',
		'order',
		'methodSelector',
		'evaluator',
		'application'
	],
	#category : 'NewTools-Inspector-Model',
	#package : 'NewTools-Inspector',
	#tag : 'Model'
}

{ #category : 'instance creation' }
StInspectionContext class >> fromPragma: aPragma [

	^ self new 
		fromPragma: aPragma;
		yourself
]

{ #category : 'accessing' }
StInspectionContext >> active: aBoolean [

	active := aBoolean
]

{ #category : 'private - factory' }
StInspectionContext >> basicNewInspectionPresenter [

	^ self basicNewInspectionPresenter: (self newPresenterBuilderOnApplication: application)
]

{ #category : 'private - factory' }
StInspectionContext >> basicNewInspectionPresenter: aBuilder [

	^ self methodSelectorNeedsBuilder 
		ifTrue: [ 
			self inspectedObject 
				inspectorPerform: self methodSelector 
				with: aBuilder ]
		ifFalse: [ 
			Warning signal: 'Inspections made without presenter builder are no longer supported. Please rewrite your inspection using it (chech in the system for examples)'.
			^ nil ]
]

{ #category : 'accessing' }
StInspectionContext >> beActive [

	self active: true
]

{ #category : 'accessing' }
StInspectionContext >> beInactive [

	self active: false
]

{ #category : 'accessing' }
StInspectionContext >> contextMethodSelector [
	| selector |

	selector := self methodSelectorNeedsBuilder
		ifTrue: [ self methodSelector allButLast ]
		ifFalse: [ self methodSelector ].
	^ (selector, 'Context:') asSymbol
]

{ #category : 'initialization' }
StInspectionContext >> debugInspectorPresenter: aBuilder [

	"Create a debug inspector presenter.
	
	I create a code presenter that contains code to recreate this presenter.
	This is useful for debugging and reporting errors when rendering/building"
	| debugExpression |

	debugExpression := String streamContents: [ :stream |
		stream nextPutAll: '"Error while creating the inspector. Debug it by executing the following:"'; cr.
		stream nextPutAll: '| collector pragma context |'; cr.
		stream nextPutAll: 'collector := StInspectionCollector on: self.'; cr.
		stream
			nextPutAll: 'pragma := (';
			nextPutAll: inspectedObject class name;
			nextPutAll: ' lookupSelector: #';
			nextPutAll: methodSelector;
			nextPutAll: ') pragmas first.'; cr.
		stream nextPutAll: 'context := collector basicContextFromPragma: pragma.'; cr.
		stream nextPutAll: 'context basicNewInspectionPresenter' ].

	"I am itself an evaluator, no need to show other."
	self withoutEvaluator.
	
	^ aBuilder newCode
		addStyle: 'stCode';
		beForObject: self inspectedObject;
		text: debugExpression;
		yourself
]

{ #category : 'accessing' }
StInspectionContext >> evaluator: aBoolean [

	evaluator := aBoolean
]

{ #category : 'initialization' }
StInspectionContext >> fromPragma: aPragma [

	self
		order: (aPragma argumentAt: 1);
		title: (aPragma argumentAt: 2);
		methodSelector: aPragma methodSelector
]

{ #category : 'testing' }
StInspectionContext >> hasEvaluator [

	^ evaluator
]

{ #category : 'initialization' }
StInspectionContext >> initialize [

	super initialize.
	active := true.
	evaluator := true
]

{ #category : 'accessing' }
StInspectionContext >> inspectedObject [

	^ inspectedObject
]

{ #category : 'accessing' }
StInspectionContext >> inspectedObject: anObject [

	inspectedObject := anObject
]

{ #category : 'testing' }
StInspectionContext >> isActive [

	^ active
]

{ #category : 'accessing' }
StInspectionContext >> methodSelector [

	^ methodSelector
]

{ #category : 'accessing' }
StInspectionContext >> methodSelector: aSelector [

	methodSelector := aSelector
]

{ #category : 'private - testing' }
StInspectionContext >> methodSelectorNeedsBuilder [

	^ self methodSelector last = $:
]

{ #category : 'private - factory' }
StInspectionContext >> newInspectionPresenterOnApplication: anApplication [
	| builder |

	builder := self newPresenterBuilderOnApplication: anApplication.
	"Create an inspection presenter for the current object and pragma.
	If creation fails, create a debug inspector instead"
	^ [ self basicNewInspectionPresenter: builder ]
		on: Exception 
		do: [ :error | self debugInspectorPresenter: builder ]
]

{ #category : 'factory' }
StInspectionContext >> newInspectionViewOnApplication: anApplication [
	| presenter |

	application := anApplication.
	presenter := self newInspectionPresenterOnApplication: anApplication.
	^ presenter ifNotNil: [ 
		presenter asInspection
			context: self;
			yourself ]
]

{ #category : 'private - factory' }
StInspectionContext >> newPresenterBuilder [

	^ SpPresenterBuilder new
		application: StPharoApplication current;
		yourself
]

{ #category : 'private - factory' }
StInspectionContext >> newPresenterBuilderOnApplication: anApplication [

	^ SpPresenterBuilder new
		application: anApplication;
		yourself
]

{ #category : 'accessing' }
StInspectionContext >> order [
	^ order
]

{ #category : 'accessing' }
StInspectionContext >> order: aNumber [

	order := aNumber
]

{ #category : 'accessing' }
StInspectionContext >> title [
	^ title
]

{ #category : 'accessing' }
StInspectionContext >> title: anObject [
	title := anObject
]

{ #category : 'accessing' }
StInspectionContext >> withEvaluator [

	self evaluator: true
]

{ #category : 'accessing' }
StInspectionContext >> withoutEvaluator [

	self evaluator: false
]
