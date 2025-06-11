Extension { #name : 'StObjectBreakpointInspection' }

{ #category : '*NewTools-ObjectCentricBreakpoints' }
StObjectBreakpointInspection classSide >> browseBreakpointMethodCommandFor: presenter [

	^ ((SpBrowseClassCommand forContext: presenter)
		selector: #doBrowseBreakpointMethod;
			asSpecCommand)
			name: 'Browse method';
			yourself
]

{ #category : '*NewTools-ObjectCentricBreakpoints' }
StObjectBreakpointInspection classSide >> objectCentricCommandsWith: presenter forRootGroup: aCmCommandsGroup [
	<extensionCommands>
	
	aCmCommandsGroup
		register: (self removeBreakpointCommandFor: presenter);
		register: (self browseBreakpointMethodCommandFor: presenter)
]

{ #category : '*NewTools-ObjectCentricBreakpoints' }
StObjectBreakpointInspection classSide >> removeBreakpointCommandFor: presenter [
	| cmd |
	cmd := StRemoveBreakpointCommand forSpecContext: presenter.
	cmd iconName: #smallDelete.
	^ cmd
]
