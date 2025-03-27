Class {
	#name : 'SpCalypsoPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'morph'
	],
	#category : 'NewTools-Window-Profiles-Tests',
	#package : 'NewTools-Window-Profiles',
	#tag : 'Tests'
}

{ #category : 'tools registration' }
SpCalypsoPresenter class >> beDefaultBrowser [
	<script>
	self registerToolsOn: Smalltalk tools
]

{ #category : 'instance creation' }
SpCalypsoPresenter class >> open [

	<script>
	^ self openOn: ClyNavigationEnvironment currentImage
]

{ #category : 'instance creation' }
SpCalypsoPresenter class >> openOn: aNavigationEnvironment [

	| browser |
	browser := self new morph on: aNavigationEnvironment.
	browser open.
	^browser
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openOn: aNavigationEnvironment withState: navigationBlock [

	| browser |
	browser := self new morph on: aNavigationEnvironment.
	browser prepareInitialStateBy: navigationBlock.
	browser open.
	^browser
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openOnClass: aClass [

	^self openWithState: [:browser | browser selectClass: aClass]
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openOnClass: aClass selector: aSymbol [

	^(aClass lookupSelector: aSymbol)
		ifNil: [ self openOnClass: aClass ]
		ifNotNil: [:method | self openOnMethod: method]
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openOnClass: aClass selector: aSymbol highlight: aString [

	| browser |
	browser := self new morph openOnClass: aClass selector: aSymbol.
	browser withTool: ClyMethodCodeEditorToolMorph do: [ :editor |
		editor selectAnyString: { aString }].
	^browser
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openOnMethod: aMethod [

	^self openWithState: [:browser | browser selectMethod: aMethod]
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openOnPackage: aPackage [

	^self openWithState: [:browser | browser selectPackage: aPackage]
]

{ #category : 'opening' }
SpCalypsoPresenter class >> openWithState: navigationBlock [

	^ self openOn: ClyNavigationEnvironment currentImage withState: navigationBlock
]

{ #category : 'tools registry' }
SpCalypsoPresenter class >> registerToolsOn: registry [

	registry register: self as: #browser
]

{ #category : 'initialization' }
SpCalypsoPresenter >> initialize [

	super initialize.
	morph := ClyFullBrowserMorph 
]

{ #category : 'accessing' }
SpCalypsoPresenter >> morph [

	^ morph
]
