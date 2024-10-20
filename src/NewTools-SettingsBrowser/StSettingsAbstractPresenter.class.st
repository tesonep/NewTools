Class {
	#name : 'StSettingsAbstractPresenter',
	#superclass : 'SpPresenter',
	#category : 'NewTools-SettingsBrowser-UI',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'UI'
}

{ #category : 'callbacks' }
StSettingsAbstractPresenter >> newNodePresenterFrom: aSettingNode level: anInteger [

	| nodePresenter |
	nodePresenter := self
		                 instantiate: aSettingNode presenterClass
		                 on: aSettingNode.
	nodePresenter sectionTitleStyle: 'sectionTitleL' , anInteger asString.
	^ nodePresenter
]

{ #category : 'accessing' }
StSettingsAbstractPresenter >> settingsTree [
	"Answer the receiver's <StSettingsTree>, the settings model"

	^ self application settingsTree.
]
