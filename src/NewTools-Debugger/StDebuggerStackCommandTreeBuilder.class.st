"
I build the default command tree for the debugger stack presenter.
The command classes I instantiate are specified under the ""accessing - commands classes"" protocol.
The group names and descriptions are specified under the ""accessing"" protocol.

You can modify the default groups names and descriptions and the default commands by modifying my code, but I am not meant to be extended through subclassing.
As I provide the default debugger commands, you should only extend me by using the Spec extension mechanism and not by subclassing me.
Using me to add command in the tree makes them default for the debugger stack presenter.
"
Class {
	#name : 'StDebuggerStackCommandTreeBuilder',
	#superclass : 'StDebuggerCommandTreeBuilder',
	#category : 'NewTools-Debugger-Model',
	#package : 'NewTools-Debugger',
	#tag : 'Model'
}

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> browseGroupName [
	^ 'Browse'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> displayStrategy [
	^CmUIDisplayAsSubMenu
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> groupDescription [
	^ 'Actions on the debugger stack.'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> groupName [ 	
	^'Stack'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackContextMenuActionsGroupName [
	^ 'Context Actions'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackContextMenuExplorationGroupName [
	^ 'Explore'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackContextNavigationGroupName [
	^ 'Receiver class code navigation commands'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackGroupName [
	^ 'Stack'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackMethodNavigationGroupName [
	^ 'Selected method navigation commands'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackMethodSelectorNavigationGroupName [
	^ 'Selected method''s selector navigation commands'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder class >> stackReceiverClassNavigationGroupName [
	^ 'Receiver class navigation commands'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> browseGroupDescription [
	^ 'Navigate the system from the stack'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> browseGroupName [
	^ self class browseGroupName
]

{ #category : 'building' }
StDebuggerStackCommandTreeBuilder >> buildDebuggerCommandGroup [
	| stackGroup |

	stackGroup := self group.	
	stackGroup decoratedGroup register: self stackContextMenuBrowseCommands.
	stackGroup decoratedGroup register: self stackContextMenuExplorationCommands.	
	stackGroup decoratedGroup register: self stackContextMenuStackEditionsCommands.
	stackGroup decoratedGroup register: self stackContextMenuActionsCommands.

	
]

{ #category : 'building' }
StDebuggerStackCommandTreeBuilder >> buildSpecCommand: aCommandClass forContext: aBlock [

	| cmd |
	cmd := super buildSpecCommand: aCommandClass forContext: stDebuggerInstance.
	cmd name: aCommandClass shortName capitalized.
	^ cmd
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackActionsCommandsClasses [
	^ {
	StReturnValueCommand
	}
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuActionsCommands [
	| group |
	
	group := (CmCommandGroup named: self stackContextMenuActionsGroupName)
		asSpecGroup.
	group beDisplayedAsGroup.
	group description: self stackContextMenuActionsDescription.
	group iconName: #smallDoIt.
	self stackActionsCommandsClasses do: [ :cmdClass | 
		group register: (self 
			buildSpecCommand: cmdClass 
			forContext: stDebuggerInstance) ].
	
	^ group
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuActionsDescription [
	^ 'Actions on the selected context'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuActionsGroupName [
	^ self class stackContextMenuActionsGroupName
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuBrowseCommands [
	| group |
	group := (CmCommandGroup named: self browseGroupName) asSpecGroup.
	group description: self browseGroupDescription.
	group iconName: #smallSystemBrowser.
	group register: self stackContextNavigationCommands.
	group register: self stackMethodNavigationCommands.
	group register: self stackMethodSelectorNavigationCommands.
	group register: self stackReceiverClassNavigationCommands.
	^ group
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuExplorationCommands [
	| group |
	group := (CmCommandGroup
		named: self stackContextMenuExplorationGroupName) asSpecGroup.
	group description: self stackContextMenuExplorationDescription.
	group iconName: SpSystemDiscoveryCommand defaultIconName.
	self stackReceiverClassExplorationCommandsClasses
		do: [ :cmdClass | 
			group
				register:
					(self
						buildSpecCommand: cmdClass
						forContext: stDebuggerInstance stackSelectionReceiverClassContext) ].
	self stackReceiverExplorationCommandsClasses
		do: [ :cmdClass | 
			group
				register:
					(self
						buildSpecCommand: cmdClass
						forContext: stDebuggerInstance stackSelectionReceiverContext) ].
	^ group
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuExplorationDescription [
	^ 'Explore the receiver object''s graph'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuExplorationGroupName [
	^ self class stackContextMenuExplorationGroupName
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackContextMenuStackEditionsCommands [
	| group |
	group := (CmCommandGroup named: self stackGroupName) asSpecGroup.
	group description: self stackGroupDescription.
	group iconName: #edit.
	self stackEditionCommandsClasses
		do: [ :cmdClass | 
			group
				register: (self buildSpecCommand: cmdClass forContext: stDebuggerInstance) ].
	^ group
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackContextNavigationCommands [
	"Commands to navigate the context"

	^ (CmCommandGroup named: self stackContextNavigationGroupName) asSpecGroup
		beDisplayedAsGroup;
		register: ((SpBrowseClassCommand forSpecContext: stDebuggerInstance)
			name: 'Method';
			yourself);
		register: (((SpBrowseClassCommand forContext: stDebuggerInstance)
			selector: #doBrowseReceiverClass;
			asSpecCommand)
				name: 'Receiver';
				shortcutKey: nil;
				yourself);
		yourself
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackContextNavigationGroupName [
	^ self class stackContextNavigationGroupName
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackEditionCommandsClasses [
	^ {
	StCopyStackToClipboardCommand.
	StPeelToFirstCommand.
	StFileOutMethodCommand
	}
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackExplorationCommandsClasses [
	^ OrderedCollection new
		addAll: self stackReceiverClassExplorationCommandsClasses;
		addAll: self stackReceiverExplorationCommandsClasses;
		yourself
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackGroupDescription [
	^ 'Stack edition'
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackGroupName [
	^ self class stackGroupName
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackMethodCommandsClasses [
	^ {
	SpBrowseMethodInheritanceCommand.
	SpBrowseMethodVersionsCommand
	}
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackMethodNavigationCommands [

	"Commands to navigate the selected context's method "

	| group |
	group := (CmCommandGroup named: self stackMethodNavigationGroupName)
		         asSpecGroup.
	group beDisplayedAsGroup.
	self stackMethodCommandsClasses do: [ :navCmdClass | 
		|cmd|
		cmd := self buildSpecCommand: navCmdClass forContext: stDebuggerInstance.
		cmd innerCommand transform: [:dbg| dbg selectedContext ].
		group register: cmd
			 ].
	^ group
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackMethodNavigationGroupName [
	^ self class stackMethodNavigationGroupName
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackMethodSelectorCommandsClasses [
	^ {
	SpBrowseImplementorsCommand.
	SpBrowseSendersCommand.
	SpBrowseMethodReferencesCommand
	}
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackMethodSelectorNavigationCommands [
	"Commands to navigate the selected context's method selector as context "

	| group |
	group := (CmCommandGroup
		named: self stackMethodSelectorNavigationGroupName) asSpecGroup.
	group beDisplayedAsGroup.
	self stackMethodSelectorCommandsClasses
		do: [ :navCmdClass | 
			group
				register:
					(self
						buildSpecCommand: navCmdClass
						forContext: stDebuggerInstance) ].
	^ group
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackMethodSelectorNavigationGroupName [
	^ self class stackMethodSelectorNavigationGroupName
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackReceiverClassExplorationCommandsClasses [
	^ {
	SpBrowseInstancesCommand.
	SpBrowseSubInstancesCommand.
	}
]

{ #category : 'commands' }
StDebuggerStackCommandTreeBuilder >> stackReceiverClassNavigationCommands [
	"Commands to navigate the selected context's receiver class as context "

	| group |
	group := (CmCommandGroup
		named: self stackReceiverClassNavigationGroupName) asSpecGroup.
	group beDisplayedAsGroup.
	self stackReceiverCommandsClasses
		do: [ :navCmdClass | 
			|cmd|
			cmd := self buildSpecCommand: navCmdClass forContext: stDebuggerInstance.
			cmd innerCommand transform: [:dbg| cmd innerCommand dynamicDebuggerContext: dbg ].
			group register: cmd ].
	^ group
]

{ #category : 'accessing' }
StDebuggerStackCommandTreeBuilder >> stackReceiverClassNavigationGroupName [
	^ self class stackReceiverClassNavigationGroupName
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackReceiverCommandsClasses [
	^ {
	SpBrowseClassReferencesCommand.
	SpBrowseClassHierarchyCommand.
	SpBrowseClassVariablesCommand.
	SpBrowseClassVarRefsCommand.
	SpBrowseInstVarRefsCommand
	}
]

{ #category : 'accessing - commands classes' }
StDebuggerStackCommandTreeBuilder >> stackReceiverExplorationCommandsClasses [
	^ {SpBrowsePointersToCommand}
]
