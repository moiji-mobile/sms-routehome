as yet unclassified
convertSMS: tpdu toDeliverSM: deliverSM

	"Look at the DCS of the message"
	(tpdu at: 'TP-DCS') = 0 ifTrue: [
		HomeRoutingTPDUHelper formatFromGSM7Bit: tpdu on: deliverSM.
		^true].
	
	(((tpdu at: 'TP-DCS') bitAnd: 2r1100) = 2r1000) ifTrue: [
		| data |
		"TODO: dead code here?"
		data := #[] toMessage.
		(tpdu at: 'TP-UDHI') ifTrue: [
			| udh |
			"Indicate we have a UDH here and assume we know the rest of the class"
			udh := (tpdu at: 'TP-UDH').
			deliverSM esmClass: 2r01000000.
			data
				putByte: udh size;
				putByteArray: udh].
		data putByteArray: (tpdu at: 'TP-UD').
		deliverSM
			dataCoding: 8;
			shortMessage: data asByteArray.
		^true
	].
	^false