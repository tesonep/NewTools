Extension { #name : 'MailMessage' }

{ #category : '*NewTools-Utils' }
MailMessage >> viewBody [
	"open a viewer on the body of this message"

	self containsViewableImage ifTrue: [ ^ self viewImageInBody ].

	(MicTextPresenter new
		 text: self bodyTextFormatted;
		 asWindow)
		title: (self name ifNil: [ '(a message part)' ]);
		open
]

{ #category : '*NewTools-Utils' }
MailMessage >> viewImageInBody [

	| stream image |
	stream := self body contentStream.
	image := Form fromBinaryStream: stream.
	SpImagePresenter new
		image: image;
		open
]
