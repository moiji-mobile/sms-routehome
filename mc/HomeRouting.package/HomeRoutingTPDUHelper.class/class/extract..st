as yet unclassified
extract: aByteArray
	| mti stream byte |
	stream := aByteArray readStream.
	byte := stream peek.

	mti := byte bitAnd: 2r11.
	mti = 1 ifTrue: [^self extractSubmitFrom: stream].
	mti = 0 ifTrue: [^self extractDeliverFrom: stream].