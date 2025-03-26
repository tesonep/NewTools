Class {
	#name : 'StDebuggerCompactToolbar',
	#superclass : 'StDebuggerToolbar',
	#instVars : [
		'toolbar',
		'menuBar'
	],
	#category : 'NewTools-Debugger-Model',
	#package : 'NewTools-Debugger',
	#tag : 'Model'
}

{ #category : 'building' }
StDebuggerCompactToolbar >> build [

	toolbarPresenter := SpPresenter new.
	toolbar := owner newToolbar.
	toolbar beIcons.
	menuBar := owner newMenuBar.
	toolbarPresenter layout: (SpBoxLayout newLeftToRight
			 add: toolbar expand: false fill: false;
			 add: menuBar expand: false fill: false;
			 yourself)
]

{ #category : 'updating' }
StDebuggerCompactToolbar >> updateWith: aCommandGroup [

	| advancedCommandsGroup menuButton |
	super updateWith: aCommandGroup.
		
	((commandsGroup groups reject: [ :g | g name = 'Advanced Step' ])
		 collect: #allCommands) flattened do: [ :command |
		| buttonPresenter |
		buttonPresenter := command
			                   configureAsToolbarButton;
			                   buildPresenter.
		buttonPresenter icon: (toolbar iconNamed: command iconName).
		toolbar add: buttonPresenter ].

	advancedCommandsGroup := commandsGroup commandOrGroupNamed:
		                         'Advanced Step'.
	menuButton := SpMenuPresenter new.
	advancedCommandsGroup allCommands do: [ :cmd |
		menuButton addItem: [ :item |
			item
				name: cmd name;
				icon: (toolbarPresenter iconNamed: cmd iconName) ] ].


	menuBar addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Advanced';
				subMenu: menuButton ] ]
]
