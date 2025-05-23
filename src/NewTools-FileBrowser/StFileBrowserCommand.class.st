"
Abstract Commander class to group File Browser commands behavior.

"
Class {
	#name : 'StFileBrowserCommand',
	#superclass : 'CmCommand',
	#category : 'NewTools-FileBrowser-Commands',
	#package : 'NewTools-FileBrowser',
	#tag : 'Commands'
}

{ #category : 'executing' }
StFileBrowserCommand >> application [

	^ self context application
]

{ #category : 'accessing' }
StFileBrowserCommand >> iconProvider [ 

	^ StFileBrowserIconCache 
]
