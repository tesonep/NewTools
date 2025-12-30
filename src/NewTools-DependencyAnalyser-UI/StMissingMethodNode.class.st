"
I'm a tree node representing a message send, at least one time, in the package under analysis having no implementor in this package and its dependencies. 
"
Class {
	#name : 'StMissingMethodNode',
	#superclass : 'StMethodDependencyNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'api' }
StMissingMethodNode >> buildChildren [
	^ self messageSendNodes
		addAll: self methodImplementationNodes;
		yourself
]

{ #category : 'api' }
StMissingMethodNode >> hasChildren [
	^ true
]

{ #category : 'accessing' }
StMissingMethodNode >> icon [
	^ self iconNamed: #testNotRun
]

{ #category : 'displaying' }
StMissingMethodNode >> label [
	^ 'Missing method: #', self content
]

{ #category : 'accessing' }
StMissingMethodNode >> messageSendAnalysis [
	^ self parentNode messageSendAnalysis
]

{ #category : 'api' }
StMissingMethodNode >> messageSendNodes [

	^ self messageSendAnalysis systemPackage methods
		  select: [ :method | method sendsSelector: self content ]
		  thenCollect: [ :method |
			  StMessageSendNode new
				  content: method;
				  parentNode: self;
				  yourself ]
]

{ #category : 'api' }
StMissingMethodNode >> methodImplementationNodes [
	^ (self content implementors collect:
		[ :method |
		StMethodImplementationNode new
			content: method;
			parentNode: self;
			yourself ])
		sorted: [ :a :b | a content package name < b content package name ]
]

{ #category : 'browse-nautilus' }
StMissingMethodNode >> selectInBrowser [
	"Nothing to browse"
]
