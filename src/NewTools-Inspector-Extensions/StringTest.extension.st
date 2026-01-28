Extension { #name : 'StringTest' }

{ #category : '*NewTools-Inspector-Extensions' }
StringTest >> testStDisplayString [

	| largeString expectedPrintSymbol |
	largeString := String loremIpsum: 1001.
	expectedPrintSymbol :=  '''' , (largeString truncateTo: 995) , '[..]'.

	self assert: 'test' stDisplayString equals: '''test'''.
	self assert: largeString stDisplayString equals: expectedPrintSymbol
]
