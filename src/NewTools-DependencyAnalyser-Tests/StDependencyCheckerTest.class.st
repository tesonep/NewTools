Class {
	#name : 'StDependencyCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'checker'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Core',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
StDependencyCheckerTest >> setUp [
	super setUp.
	checker := StDependencyChecker new
]

{ #category : 'tests' }
StDependencyCheckerTest >> testShouldGetDirectDependencies [
	self
		assert: (checker dependenciesOf: 'NewTools-DependencyAnalyser-Tests-Data')
		equals: #(#Kernel #'Kernel-BytecodeEncoders')
]

{ #category : 'tests' }
StDependencyCheckerTest >> testShouldGetUnresolvedDependencies [

	| result |
	result := (checker unresolvedDependenciesOf: 'NewTools-DependencyAnalyser-Tests-Data').
	self
		assert: result size
		equals: 2.
	self flag: #Torevisit.
	"I do not like to have a dependency on another tools. It would be better to check against a lib in a lower layer."
	self assert: ((result at: #collect:as:) includesAll: #(#'NewTools-Spotter' #'Collections-Abstract'))
]
