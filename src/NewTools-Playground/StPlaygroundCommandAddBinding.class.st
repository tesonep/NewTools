Class {
	#name : 'StPlaygroundCommandAddBinding',
	#superclass : 'StPlaygroundCommand',
	#category : 'NewTools-Playground-Command',
	#package : 'NewTools-Playground',
	#tag : 'Command'
}

{ #category : 'executing' }
StPlaygroundCommandAddBinding >> execute [ 
	(StPlaygroundBindingPresenter 
		model: context)
		open
]
