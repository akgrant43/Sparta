accessing
flush
	self isValid
		ifFalse: [ self error: 'Svg canvas is no more valid. Create a new one' ].

	super flush.
	self surface release.
	self release