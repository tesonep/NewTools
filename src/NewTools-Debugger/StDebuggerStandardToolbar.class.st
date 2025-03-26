Class {
	#name : 'StDebuggerStandardToolbar',
	#superclass : 'StDebuggerToolbar',
	#category : 'NewTools-Debugger-Model',
	#package : 'NewTools-Debugger',
	#tag : 'Model'
}

{ #category : 'building' }
StDebuggerStandardToolbar >> build [

	toolbarPresenter := owner newToolbar.
	toolbarPresenter addStyle: 'stToolbar'.
	toolbarPresenter displayMode: owner application toolbarDisplayMode
]

{ #category : 'updating' }
StDebuggerStandardToolbar >> updateWith: aCommandGroup [

	super updateWith: aCommandGroup.
	SpToolbarPresenterBuilder new
		toolbarPresenter: self toolbarPresenter;
		visit: commandsGroup
]
