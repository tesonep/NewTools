Extension { #name : 'StDebugger' }

{ #category : '*NewTools-Sindarin-Commands' }
StDebugger class >> buildSindarinExtentionCommandsGroupWith: stDebuggerInstance forRoot: rootCommandGroup [

	<extensionCommands>
	| commands codeGroup  toolbarSindarinGroup |
	commands := (Pragma allNamed: #codeExtensionDebugCommand:) collect: [ 
		            :prg | 
		            | class |
		            class := prg methodClass soleInstance.
		            class forSpecContext: stDebuggerInstance ].


	codeGroup := self debuggerCodeCommandGroupFor: rootCommandGroup.
	commands do: [ :c | codeGroup register: c ].

	toolbarSindarinGroup := CmCommandGroup forSpec
			beToolbarPopoverButton;
			name: 'Advanced';
			icon: (stDebuggerInstance application iconNamed: #smallDebugIt);
			yourself.
	(self debuggerToolbarCommandGroupFor: rootCommandGroup) register: toolbarSindarinGroup.
	commands do: [ :c | toolbarSindarinGroup register: c ].		 
]
