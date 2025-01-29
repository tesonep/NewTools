Extension { #name : 'OCProgramNode' }

{ #category : '*NewTools-Inspector-Extensions' }
OCProgramNode >> inspectionAST: aBuilder [
	<inspectorPresentationOrder: 35 title: 'AST'>

	^ aBuilder newTree 
		roots: { self };
		children: [ :aNode | aNode children ];
		display: [ :each | 
			String
				streamContents: [ :stream | 
					stream
						nextPutAll: each class name;
						nextPut: $(;
						nextPutAll: ((each formattedCode truncateTo: 50) copyReplaceAll: String cr with: String space);
						nextPut: $)
			 ] ];
		yourself
]

{ #category : '*NewTools-Inspector-Extensions' }
OCProgramNode >> inspectionASTDump: aBuilder [
	<inspectorPresentationOrder: 50 title: 'AST Dump'>

	^ aBuilder newCode 
		text: (RBParser parseExpression: self dump) formattedCode; 
		beForScripting; "this is an expression"
		yourself
]

{ #category : '*NewTools-Inspector-Extensions' }
OCProgramNode >> inspectionSource: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Method Source'>

	^ aBuilder newCode 
		beForMethod: self methodNode;
		text: (self source ifNil: [ self formattedCode ]);
		addTextSegmentDecoration: (SpTextPresenterDecorator forHighlight
			interval: (self sourceInterval first to: self sourceInterval last + 1);
			yourself);
		yourself
]
