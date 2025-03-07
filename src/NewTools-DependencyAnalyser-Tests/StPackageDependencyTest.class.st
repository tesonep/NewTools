Class {
	#name : 'StPackageDependencyTest',
	#superclass : 'TestCase',
	#instVars : [
		'aPackageDependency',
		'anInternalPackageDependency',
		'packageA',
		'packageB'
	],
	#category : 'NewTools-DependencyAnalyser-Tests-Packages',
	#package : 'NewTools-DependencyAnalyser-Tests',
	#tag : 'Packages'
}

{ #category : 'running' }
StPackageDependencyTest >> inheritanceDependency: aClass [
	^ (StInheritanceDependency from: packageA to: packageB)
		theClass: aClass;
		superclass: nil;
		yourself
]

{ #category : 'running' }
StPackageDependencyTest >> referenceDependency: aClass [
	^ (StReferenceDependency from: packageA to: packageB)
		theClass: aClass;
		selector: nil;
		reference: nil;
		method: nil;
		yourself
]

{ #category : 'running' }
StPackageDependencyTest >> setUp [

	| source target |
	super setUp.
	source := StPackage onPackageNamed: 'Kernel'.
	target := StPackage onPackageNamed: 'Collections-Abstract'.
	aPackageDependency := StPackageDependency from: source to: target.
	anInternalPackageDependency := StPackageDependency from: source to: source.
	packageA := StPackage onPackageNamed: 'A'.
	packageB := StPackage onPackageNamed: 'B'
]

{ #category : 'tests' }
StPackageDependencyTest >> testContainsOnlyExtensionDependency [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency
		from: (packageA)
		to: (packageB).
	aCompositeDependency
		add:
			(StInheritanceDependency from: (packageA) to: (packageB));
		add:
			(StInheritanceDependency from: (packageA) to: (packageB)).
	self deny: (aCompositeDependency containsOnlyExtensionDependency).
	aCompositeDependency dependencies removeAll.
		aCompositeDependency
		add:
			(StExtensionDependency from: (packageA) to: (packageB));
		add:
			(StExtensionDependency from: (packageA) to: (packageB)).
	self assert: (aCompositeDependency containsOnlyExtensionDependency)
]

{ #category : 'tests' }
StPackageDependencyTest >> testDependenciesFrom [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency from: packageA to: packageB.
	aCompositeDependency
		add: (self referenceDependency: String);
		add: (self referenceDependency: Object);
		add: (self referenceDependency: String);
		add: (self inheritanceDependency: Stack).
	self assert: (aCompositeDependency referenceDependenciesFrom: String) size equals: 2
]

{ #category : 'tests' }
StPackageDependencyTest >> testDependenciesSize [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency from: packageA to: packageB.
	aCompositeDependency
		add: (StInheritanceDependency from: packageA to: packageB);
		add: (StInheritanceDependency from: packageA to: packageB).
	self assert: aCompositeDependency extensionDependenciesSize equals: 0.
	aCompositeDependency add: (StExtensionDependency from: packageA to: packageB).
	self assert: aCompositeDependency extensionDependenciesSize equals: 1
]

{ #category : 'tests' }
StPackageDependencyTest >> testDependenciesWithoutExtensionDependency [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency from: packageA to: packageB.
	aCompositeDependency
		add: (StInheritanceDependency from: packageA to: packageB);
		add: (StInheritanceDependency from: packageA to: packageB);
		add: (StExtensionDependency from: packageA to: packageB).
	self assert: aCompositeDependency dependenciesWithoutExtensionDependency size equals: 2
]

{ #category : 'tests' }
StPackageDependencyTest >> testEquals [
	self assert: aPackageDependency equals: aPackageDependency
]

{ #category : 'tests' }
StPackageDependencyTest >> testExtensionDependencies [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency
		from: (packageA)
		to: (packageB).
	aCompositeDependency
		add:
			(StExtensionDependency from: (packageA) to: (packageB));
		add:
			(StInheritanceDependency from: (packageA) to: (packageB)).
	self assert: (aCompositeDependency extensionDependencies allSatisfy: [ :each | each isExtensionDependency ])
]

{ #category : 'tests' }
StPackageDependencyTest >> testIsExternal [
	self assert: (aPackageDependency isExternal)
]

{ #category : 'tests' }
StPackageDependencyTest >> testIsInternal [
	self assert: (anInternalPackageDependency isInternal)
]

{ #category : 'tests' }
StPackageDependencyTest >> testReferenceDependencies [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency from: packageA to: packageB.
	aCompositeDependency
		add: (self referenceDependency: String);
		add: (self referenceDependency: Object);
		add: (StInheritanceDependency from: packageA to: packageB).

	self assert: aCompositeDependency referenceDependencies size equals: 2
]

{ #category : 'tests' }
StPackageDependencyTest >> testReferenceDependenciesFrom [
	| aCompositeDependency |
	aCompositeDependency := StCompositeDependency from: packageA to: packageB.
	aCompositeDependency
		add: (self referenceDependency: String);
		add: (self referenceDependency: Object);
		add: (self referenceDependency: String).

	self assert: (aCompositeDependency referenceDependenciesFrom: String) size equals: 2
]
