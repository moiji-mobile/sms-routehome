as yet unclassified
formatToGSM7Bit: tpdu on: smppMessage
	| udhi udh dataPacked skipBytes data input padding |
	skipBytes := 0.
	padding := 0.
	udh := #[] toMessage.
	data := #[] toMessage.
	
	input := smppMessage shortMessage readStream.
	udhi := (smppMessage esmClass bitAnd: 2r01000000) > 0.

	udhi ifTrue: [
		| len tmp fillBits |
		len := input next.
		tmp := input next: len.
		tmp size = len ifFalse: [
			^self error: 'Short read on UDH'].
		udh putByteArray: tmp.
		data putByte: len.
		data putByteArray: udh.

		skipBytes := (((udh size)* 8) \\ 7).
		fillBits := 7 - skipBytes.
		fillBits > 0 ifTrue: [
			skipBytes := skipBytes + 1.
			padding := 1.
			data putByte: 0]].

	"Does the UDH stop on a 7bit boundary? If not we need to add padding.."
	data putByteArray: input upToEnd asByteArray.
	dataPacked := (GSMEncoding compact: data) allButFirst: skipBytes.

	"Set the data"
	tpdu at: 'TP-UDHI' put: udhi.
	tpdu at: 'TP-UDH' put: udh toByteArray.
	tpdu at: 'TP-UD-Len' put: smppMessage shortMessage size + padding.
	tpdu at: 'TP-UD' put: dataPacked.