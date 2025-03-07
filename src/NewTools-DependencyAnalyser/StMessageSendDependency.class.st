"
I represent a potential Dependency on a Package because it implements a method called by the package under analysis but the method is not implemented in the package, neither in the static dependencies of this package (inheritence, reference, trait, extension).
"
Class {
	#name : 'StMessageSendDependency',
	#superclass : 'StDependencyFromClass',
	#instVars : [
		'implementedMethods'
	],
	#category : 'NewTools-DependencyAnalyser-Core',
	#package : 'NewTools-DependencyAnalyser',
	#tag : 'Core'
}

{ #category : 'setting' }
StMessageSendDependency >> implementedMethods: aListOfSelectors [
	implementedMethods := aListOfSelectors
]

{ #category : 'testing' }
StMessageSendDependency >> isMessageSendDependency [
	^ true
]

{ #category : 'accessing' }
StMessageSendDependency >> users [

	^ source systemPackage methods
		  select: [ :method | method messages includesAny: implementedMethods ]
		  thenCollect: [ :method | method -> (method messages intersection: implementedMethods) ]
]
