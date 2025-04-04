"
I am wrapper for packages to be used in the ScopeNodesTree
"
Class {
	#name : 'ScopePackageNode',
	#superclass : 'ScopeNode',
	#category : 'NewTools-Scopes-Editor-Nodes',
	#package : 'NewTools-Scopes-Editor',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
ScopePackageNode >> children [

	^ value definedClasses asOrderedCollection collect: [ :classOrTrait |
		  classOrTrait isClassOrTrait ifFalse: [
			  self error: 'child must be a class or a trait' ].
		  classOrTrait isTrait
			  ifTrue: [ ScopeTraitNode on: classOrTrait ]
			  ifFalse: [ ScopeClassNode on: classOrTrait ] ]
]

{ #category : 'accessing' }
ScopePackageNode >> definedClasses [
	^ value definedClasses
]

{ #category : 'testing' }
ScopePackageNode >> isPackageNode [
	^ true
]

{ #category : 'accessing' }
ScopePackageNode >> packageNode [
	^ self
]

{ #category : 'accessing' }
ScopePackageNode >> scopesIconName [
	^ #package
]
