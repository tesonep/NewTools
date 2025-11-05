Extension { #name : 'StringTest' }

{ #category : '*NewTools-Inspector-Extensions' }
StringTest >> testStDisplayString [

	self assert: #test stDisplayString equals: '#test'.
	self assert: #'#test' stDisplayString equals: '#''#test'''
]
