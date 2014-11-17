as yet unclassified
formatForDeliverSM: tpdu on: deliverSM
	"Depending on the TPDU we have to set the esmClass, dcs and either
	the short message."

	"We would need to set esmClass and look at the TP-UD front."
	(tpdu at: 'TP-RP')
		ifTrue: [self reportUnhandled: tpdu. ^nil].

	deliverSM
		esmClass: 0;
		protocolId: 0.		

	"Look at the DCS of the message"
	(tpdu at: 'TP-DCS') = 0 ifTrue: [
		HomeRoutingTPDUHelper formatFromGSM7Bit: tpdu on: deliverSM.
		^deliverSM].
	
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
		^deliverSM
			dataCoding: 8;
			shortMessage: data asByteArray;
			yourself
	].

	self reportUnhandled: tpdu.
	^nil