Extension { #name : 'Process' }

{ #category : '*NewTools-ProcessBrowser' }
Process class >> allProcesses [

	self flag: #TODO. "This should be something in the core, I think (and it requires a better 
	recognition algoritm)"
	^ self allSubInstances
]
