"
A DAPackageNode is used to display a package in a tree.
"
Class {
	#name : 'StPackageUnderAnalysisNode',
	#superclass : 'StAbstractPackageNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'comparing' }
StPackageUnderAnalysisNode >> <= aDANode [
	^ (aDANode class respondsTo: #packageName) and: [ self packageName <= aDANode packageName ]
]

{ #category : 'dependencies' }
StPackageUnderAnalysisNode >> assemblyNodeFor: anAssemblyManifest [
	^ (StAssemblyNode newWith: (self packageDependencies
			select: [ :dependency | anAssemblyManifest includes: dependency packageName ]
			thenCollect: #asPackageDependencyWrapper))
		content: anAssemblyManifest packageName;
		yourself
]

{ #category : 'dependencies' }
StPackageUnderAnalysisNode >> assemblyNodesFor: aListOfAssemblyManifest [
	^ aListOfAssemblyManifest
		collect: [ :each | self assemblyNodeFor: each ]
		as: OrderedCollection
]

{ #category : 'api' }
StPackageUnderAnalysisNode >> childNodeClassFor: anItem [
	 ^ anItem nodeClass
]

{ #category : 'accessing' }
StPackageUnderAnalysisNode >> children [
	^ (self packageDependencies"GroupedByAssembly" sort: [ :a :b | a packageName < b packageName])
		copyWith: StPotentialDependenciesNode new
]

{ #category : 'accessing' }
StPackageUnderAnalysisNode >> daPackage [
	^ self content
]

{ #category : 'testing' }
StPackageUnderAnalysisNode >> hasChildren [
	^ [ true ]
]

{ #category : 'accessing' }
StPackageUnderAnalysisNode >> icon [
	^ self iconNamed: #package
]

{ #category : 'testing' }
StPackageUnderAnalysisNode >> isPackageNode [
	^ true
]

{ #category : 'accessing' }
StPackageUnderAnalysisNode >> manuallyResolvedDependencies [
	^ self packageUnderAnalysis manuallyResolvedDependencies
		collect: [ :packageName | StManuallyAddedDependentPackageNode new content: packageName ]
]

{ #category : 'dependencies' }
StPackageUnderAnalysisNode >> packageDependencies [
	^ self rootNode isCycle
		ifTrue: [ self rootNode content dependentPackagesFrom: self content ]
		ifFalse: [ self content dependencies ]
]

{ #category : 'accessing' }
StPackageUnderAnalysisNode >> packageName [
	^ self daPackage packageName
]

{ #category : 'printing' }
StPackageUnderAnalysisNode >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self content printOn: aStream.
	aStream nextPut: $)
]

{ #category : 'dependencies' }
StPackageUnderAnalysisNode >> wrappedPackageDependencies [
	^ (self packageDependencies
		collect: #asPackageDependencyWrapper
		as: OrderedCollection) sorted
]
