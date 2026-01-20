Class {
	#name : 'StSettingsStyleContributor',
	#superclass : 'StPharoStyleContributor',
	#category : 'NewTools-SettingsBrowser-UI',
	#package : 'NewTools-SettingsBrowser',
	#tag : 'UI'
}

{ #category : 'styling' }
StSettingsStyleContributor class >> styleSheet [

	^ SpStyleVariableSTONReader fromString: self styleSheetString
]

{ #category : 'as yet unclassified' }
StSettingsStyleContributor class >> styleSheetData [

	^ '.application [
    .superCategoryList [ Geometry { #height: 70 } ],
	.pageTitle [ 
		Font { #name : EnvironmentFont(#default), #size : 20 },
		Geometry { #height: 15 } ],
	.pageStyle [ 
		Draw { #backgroundColor: #transparent },
		Container { #padding: 2 } ],
	.sectionTitleL1 [ 
		Draw { #backgroundColor: #gray },
		Font { #size: 16 } ],
	.sectionTitleL2 [ 
		Draw { #backgroundColor: #lightGray },
		Font { #size: 14 } ],
	.sectionTitleL3 [ 
		Draw { #backgroundColor: #veryLightGray },
		Font { #size: 12 } ],
	.sectionTitleL4 [ 
		Draw { #backgroundColor: #veryVeryLightGray },
		Font { #size: 10 } ],
	.sectionStyle [ 
		Draw { #backgroundColor: #transparent }
	 ],
	.settingDocTitle [ 
		Draw { #backgroundColor: #veryVeryLightGray } ], 
	.settingItemStyle [ 
		Container { #borderWidth: 5 } ],
	.descriptionStyle [ 
		Draw { #backgroundColor: EnvironmentColor(lightBackground) } ] ]'
]

{ #category : 'styles' }
StSettingsStyleContributor >> styleSheetContribution [
	
	^ SpStyleVariableSTONReader fromString: self styleSheetData
]

{ #category : 'private' }
StSettingsStyleContributor >> styleSheetData [

	^ '.application [
.settingHeader [ 
		Container { #borderWidth: 2 },
		Geometry { #minHeight: 30, #height: 30 },
		Draw { #backgroundColor: EnvironmentColor(#border) },
		.settingLabel [
			Draw { #color : #red  },
			Font { #name : EnvironmentFont(#default), #size : 14 } ]
],
.labeledPresenter [ Container { #borderWidth: 2 } ],
.labeledPresenterLabel [ Geometry { #minWidth: 300, #width: 300 } ],
.labeledPresenterInput [ Geometry { #minWidth: 300, #width: 300 } ] 
]'.
]
