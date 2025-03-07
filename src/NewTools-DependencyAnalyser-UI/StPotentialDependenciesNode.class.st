"
I'm a node allowing to compute and browse potential dependencies of a package, i.e. messages sent in the package but with no corresponding method in the package or in its dependencies.
"
Class {
	#name : 'StPotentialDependenciesNode',
	#superclass : 'StDependentPackageNode',
	#instVars : [
		'messageSendAnalysis'
	],
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'api' }
StPotentialDependenciesNode >> buildChildren [
	^ (self messageSendAnalysis unimplementedCallsInAllDependencies
		collect: [ :selector |
						(StMissingMethodNode new
								content: selector;
								parentNode: self;
								yourself) ]
		as: Array)
			sort: [ :a :b | a content < b content ]
]

{ #category : 'accessing' }
StPotentialDependenciesNode >> content [
	^ 'Potential dependencies'
]

{ #category : 'accessing' }
StPotentialDependenciesNode >> extensionDependenciesSize [
	^ 0
]

{ #category : 'accessing' }
StPotentialDependenciesNode >> hasChildren [
	^ true
]

{ #category : 'accessing' }
StPotentialDependenciesNode >> icon [
	^ self iconNamed: #smallHelp
]

{ #category : 'testing' }
StPotentialDependenciesNode >> isPackageNode [
	^ false
]

{ #category : 'displaying' }
StPotentialDependenciesNode >> label [
	^ self content
]

{ #category : 'accessing' }
StPotentialDependenciesNode >> messageSendAnalysis [
	[ messageSendAnalysis ifNil: [ messageSendAnalysis := StMessageSendAnalyzer on: self parentNode content packageName ] ]
		on: StPotentialOutDatedDependencyWarning
		do: [ :ex | ex resume. "ignore. We already got an alert box" ].
	^ messageSendAnalysis
]

{ #category : 'compatibility' }
StPotentialDependenciesNode >> numberOfDependencies [
	^ 0
]

{ #category : 'browse-nautilus' }
StPotentialDependenciesNode >> selectInBrowser [
	self selectMethod:
		([ self packageUnderAnalysis packageManifest class methodNamed: #manuallyResolvedDependencies ]
			on: KeyNotFound
			do: [ PackageManifest class>>#manuallyResolvedDependencies ])
]
