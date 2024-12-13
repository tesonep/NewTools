Extension { #name : 'DebugPointIconStyler' }

{ #category : '*NewTools-Debugger' }
DebugPointIconStyler >> buildIconStyleFor: dp to: aNode [
	"there probably is a better way that just adding a second row but i couldn't figure out rubric"

	| r |
	r := self segmentMorphClass from: aNode start to: aNode stop + 1.

	r label: (self iconLabelBlock: dp).
	r icon: (self iconFor: dp).
	r iconBlock: (self iconBlock: dp).
	r color: self highlightColor.
	r borderColor: self borderColor.
	^ r
]
