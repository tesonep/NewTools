Extension { #name : 'PragmaSetting' }

{ #category : '*NewTools-SettingsBrowser' }
PragmaSetting >> asSettingPresenterWithOwner: aPresenter [
	"Answer an appropriate <SpPresenter> container for the receiver's value"

	^ aPresenter newLabel 
		label: self label;
		yourself
]
