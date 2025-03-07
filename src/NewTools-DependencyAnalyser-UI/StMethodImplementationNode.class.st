"
I'm a tree node representing a method implementation
"
Class {
	#name : 'StMethodImplementationNode',
	#superclass : 'StMethodDependencyNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'building-menu' }
StMethodImplementationNode >> addMenuActionsOn: anActionGroup [
	| method |
	
	method := self content.
	anActionGroup addActionWith: [ :action | action
		name: 'Select this package as the right dependency';
		action: [
			(TheManifestBuilder of: self packageUnderAnalysis packageManifest)
				addManuallyResolvedDependency: method package name.
				"TODO: run the analysis again" ] ]
]

{ #category : 'accessing' }
StMethodImplementationNode >> icon [
	^ self iconNamed: #package
]

{ #category : 'displaying' }
StMethodImplementationNode >> label [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: 'Implemented in ';
			nextPutAll: self content package name;
			nextPutAll: ': #';
			nextPutAll: self content methodClass name ]
]
