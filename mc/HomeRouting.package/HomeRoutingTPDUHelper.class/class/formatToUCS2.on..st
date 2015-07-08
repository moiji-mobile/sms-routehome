as yet unclassified
formatToUCS2: tpdu on: smppMessage 
	| udhi udh  data input  |

	udh := #[] toMessage.
	data := #[] toMessage.
	
	input := smppMessage shortMessage asByteArray readStream.
	udhi := (smppMessage esmClass bitAnd: 2r01000000) > 0.

	"Take it and remember it separately"
	udhi ifTrue: [
		| len tmp  |
		len := input next.
		tmp := input next: len.
		tmp size = len ifFalse: [
			^self error: 'Short read on UDH'].
		udh putByteArray: tmp].

	data putByteArray: input upToEnd asByteArray.

	"Set the data"
	tpdu at: 'TP-UDHI' put: udhi.
	tpdu at: 'TP-UDH' put: udh toByteArray.
	tpdu at: 'TP-UD-Len' put: data size.
	tpdu at: 'TP-UD' put: data toByteArray