"
I am a command that open the expression finder presenter from another presenter keeping the same code.

I can be converted into a sepc button to be used in a presenter
"
Class {
	#name : 'StRewriterOpenExpressionFinderCommand',
	#superclass : 'StCommand',
	#category : 'NewTools-RewriterTools-Commands',
	#package : 'NewTools-RewriterTools',
	#tag : 'Commands'
}

{ #category : 'default' }
StRewriterOpenExpressionFinderCommand class >> defaultDescription [

	^ 'Find ocurrences of an expression in all Pharo''s code'
]

{ #category : 'accessing' }
StRewriterOpenExpressionFinderCommand class >> defaultIconName [

	^ StRewriterExpressionFinderPresenter iconName
]

{ #category : 'default' }
StRewriterOpenExpressionFinderCommand class >> defaultName [

	^ 'Find occurrences'
]

{ #category : 'executing' }
StRewriterOpenExpressionFinderCommand >> execute [

	^ (StRewriterExpressionFinderPresenter
			newApplication: self application)
			patternCode: self context lhs;
			open
]
