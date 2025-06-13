Class {
	#name : 'StSindarinDebuggerScriptRepositoryChooserPresenter',
	#superclass : 'SpDropListPresenter',
	#category : 'NewTools-Sindarin-Tools-Presenters',
	#package : 'NewTools-Sindarin-Tools',
	#tag : 'Presenters'
}

{ #category : 'api' }
StSindarinDebuggerScriptRepositoryChooserPresenter >> display [ 
	^ [ :e | e repositoryName ].
]

{ #category : 'initialization' }
StSindarinDebuggerScriptRepositoryChooserPresenter >> findRepositories [
	self items: StSindarinDebuggerScriptRepository subclasses
]
