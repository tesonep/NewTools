Extension { #name : 'q\nCompiledMethod' }

{ #category : '*NewTools-Inspector-Extensions' }
q
CompiledMethod >> inspectionSource: aBuilder [
	<inspectorPresentationOrder: 20 title: 'Method Source'>
	
	^ aBuilder newCode 
		beForMethod: self method;
		text: (self sourceCode ifNil: [ 'Apparently method ', self methodClass name, '>>#', self selector, ' is missing its source!']);
		actionsWith: [ :group | group 
			addActionWith: [ :action | action
				name: 'Browse method class'; 
				action: [ self methodClass browse ] ] ];
		whenSubmitDo: [ :text | 
			self isInstalled 
				ifFalse: [ UIManager default inform: 'can not edit methods that are not installed' ]
				ifTrue: [ self methodClass compile: text ] ];
		yourself
]
