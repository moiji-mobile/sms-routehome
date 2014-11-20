as yet unclassified
formatToGSM7Bit: tpdu on: smppMessage
	| udhi udh dataPacked padding |
	padding := 0.
	udh := #[] toMessage.

	udhi := (smppMessage esmClass bitAnd: 2r01000000) > 0.

	udhi ifTrue: [
		| len tmp input |
		input := smppMessage shortMessage readStream.
		len := input next.
		tmp := input next: len.
		tmp size = len ifFalse: [
			^self error: 'Short read on UDH'].
		udh putByteArray: tmp.
		padding := 1.
	].

	"Does the UDH stop on a 7bit boundary? If not we need to add padding.."
	dataPacked := GSMEncoding compact: smppMessage shortMessage.

	"We need to skip some octets of (udh size) * 8 // 7..."
	udh size = 0 ifFalse: [
		| skip fillBits |
		skip := (((udh size)* 8) \\ 7).
		fillBits := 7 - skip.
		fillBits > 0
			ifTrue: [skip := skip + 1].

		dataPacked := dataPacked allButFirst: skip.
	].

	"Set the data"
	tpdu at: 'TP-UDHI' put: udhi.
	tpdu at: 'TP-UDH' put: udh toByteArray.
	tpdu at: 'TP-UD-Len' put: smppMessage shortMessage size + padding.
	tpdu at: 'TP-UD' put: dataPacked.