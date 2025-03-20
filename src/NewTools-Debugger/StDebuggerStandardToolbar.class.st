Class {
	#name : 'StDebuggerStandardToolbar',
	#superclass : 'StDebuggerToolbar',
	#category : 'NewTools-Debugger-Model',
	#package : 'NewTools-Debugger',
	#tag : 'Model'
}

{ #category : 'building' }
StDebuggerStandardToolbar >> build [
	presenter := owner newToolbar.
	presenter addStyle: 'stToolbar'.
	presenter displayMode: owner application toolbarDisplayMode
]

{ #category : 'updating' }
StDebuggerStandardToolbar >> updateWith: aCommandGroup [

	super updateWith: aCommandGroup.
	SpToolbarPresenterBuilder new
		toolbarPresenter: self presenter;
		visit: commandsGroup
]
