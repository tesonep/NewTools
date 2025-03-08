"
I reprensent a package assembly (i.e. a set of packages).
I collect all dependencies related to the assembly parts.
"
Class {
	#name : 'StAssemblyNode',
	#superclass : 'StNode',
	#instVars : [
		'dependencies'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'instance creation' }
StAssemblyNode class >> newWith: aCollection [
	^ self basicNew
		initializeWith: aCollection;
		yourself
]

{ #category : 'api' }
StAssemblyNode >> childNodeClassFor: anItem [
	^ StDependentPackageNode
]

{ #category : 'accessing' }
StAssemblyNode >> children [
	^ dependencies
]

{ #category : 'accessing' }
StAssemblyNode >> daPackage [
	^ self parentNode daPackage
]

{ #category : 'accessing' }
StAssemblyNode >> dependencies [
	^ dependencies
]

{ #category : 'testing' }
StAssemblyNode >> hasChildren [
	^ true
]

{ #category : 'accessing' }
StAssemblyNode >> icon [
	^ self iconNamed: #forward
]

{ #category : 'testing' }
StAssemblyNode >> includes: aPackageName [
	^ (self dependencies collect: [:aDep | aDep packageName]) includes: aPackageName
]

{ #category : 'initialization' }
StAssemblyNode >> initializeWith: aCollection [
	self initialize.
	dependencies := aCollection
]

{ #category : 'displaying' }
StAssemblyNode >> label [
	^ self content
]

{ #category : 'browse-nautilus' }
StAssemblyNode >> selectInBrowser [
	"nothing to browse"
]
