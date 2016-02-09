as yet unclassified
formatFromOctets: tpdu on: smppMessage
	| data  udhi |
	data := #[] toMessage.
	
	udhi  := tpdu at: 'TP-UDHI'.
	udhi ifTrue: [
		| udh |
		"Indicate we have a UDH here and assume we know the rest of the class"
		udh := (tpdu at: 'TP-UDH').
		smppMessage esmClass: 2r01000000.
		data
			putByte: udh size;
			putByteArray: udh.
	].

	data putByteArray: (tpdu at: 'TP-UD').

	^smppMessage
		shortMessage: data asByteArray;
		yourself