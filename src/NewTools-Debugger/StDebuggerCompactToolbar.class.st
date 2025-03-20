Class {
	#name : 'StDebuggerCompactToolbar',
	#superclass : 'StDebuggerToolbar',
	#category : 'NewTools-Debugger-Model',
	#package : 'NewTools-Debugger',
	#tag : 'Model'
}

{ #category : 'building' }
StDebuggerCompactToolbar >> build [
	presenter := owner newMenuBar
]

{ #category : 'updating' }
StDebuggerCompactToolbar >> updateWith: aCommandGroup [

	super updateWith: aCommandGroup.

	presenter addGroup: [ :group |
		(commandsGroup allCommands collect: #decoratedCommand) do: [
			:command |
			group addItem: [ :item |
				item
					name: command name;
					description: command description;
					icon: (owner iconNamed: command class defaultIconName);
					action: [ command execute ] ] ] ]
]
