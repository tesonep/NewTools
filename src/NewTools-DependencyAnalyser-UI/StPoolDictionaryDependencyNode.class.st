"
I am a tree node showing pool dictionary dependencies.
I define an icon for pool dictionaries and spawn a new browser on the pool dictionary when browsing the dependency.
"
Class {
	#name : 'StPoolDictionaryDependencyNode',
	#superclass : 'StClassNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StPoolDictionaryDependencyNode >> icon [

	^ self iconNamed: #classVarsSelected
]

{ #category : 'browse-nautilus' }
StPoolDictionaryDependencyNode >> spawnNewBrowser [
	self browseClass: self content poolDictionary
]
