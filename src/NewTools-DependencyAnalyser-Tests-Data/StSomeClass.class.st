"
A simple class to test dependency analyzer
"
Class {
	#name : 'StSomeClass',
	#superclass : 'Object',
	#category : 'NewTools-DependencyAnalyser-Tests-Data',
	#package : 'NewTools-DependencyAnalyser-Tests-Data'
}

{ #category : 'tests - test data' }
StSomeClass >> method1 [
	<ignoreNotImplementedSelectors: #(unimplementedMethod)>
	self unimplementedMethod
]

{ #category : 'tests - test data' }
StSomeClass >> method2 [
	"a message send not in Kernel package"
	(1 to: 3)
		collect: [ :i | i * 2 ]
		as: (self class environment at: #Array) "avoid a direct reference to Array"
]

{ #category : 'tests - test data' }
StSomeClass >> method3 [
	"We refer a class indirectly in a block"
	^ [ EncoderForSistaV1 new ] value
]

{ #category : 'tests - test data' }
StSomeClass >> method4: x [
	"a message send not in Kernel package used in a block"
	[ x copyFrom: 1 to: 2 ] value
]
