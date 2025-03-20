"
I'm a node  representing a dependency not computed automatically but added manually on the package Manifest.
"
Class {
	#name : 'StManuallyAddedDependentPackageNode',
	#superclass : 'StDependentPackageNode',
	#category : 'NewTools-DependencyAnalyser-UI-Nodes',
	#package : 'NewTools-DependencyAnalyser-UI',
	#tag : 'Nodes'
}

{ #category : 'accessing' }
StManuallyAddedDependentPackageNode >> children [
	^ self content dependencies flatCollect:
		[ :dependency |
		dependency users collect:
			[ :association | | method sentMessages |
			method := association key.
			sentMessages := association value.
			StMessageSendDependencyNode new
				content: method;
				parentNode: self;
				sentMessages: sentMessages
				yourself ] ]
]

{ #category : 'accessing' }
StManuallyAddedDependentPackageNode >> hasChildren [
	^ [ self children isNotEmpty ]
]

{ #category : 'accessing' }
StManuallyAddedDependentPackageNode >> icon [
	^ self iconNamed: #smallRedo
]

{ #category : 'browse-nautilus' }
StManuallyAddedDependentPackageNode >> selectInBrowser [
	"Nothing to do"
]
