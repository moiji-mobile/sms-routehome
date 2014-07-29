smpp
formatForDeliverSM: tpdu on: deliverSM
	"Depending on the TPDU we have to set the esmClass, dcs and either
	the short message."

	"We would need to set esmClass and look at the TP-UD front."
	(tpdu at: 'TP-RP')
		ifTrue: [self reportUnhandled: tpdu. ^nil].
	(tpdu at: 'TP-UDHI')
		ifTrue: [self reportUnhandled: tpdu. ^nil].
		
	deliverSM
		esmClass: 0;
		protocolId: 0.

	"Look at the DCS of the message"
	(tpdu at: 'TP-DCS') = 0 ifTrue: [
		| bytes |
		bytes := GSMDecoding expand: (tpdu at: 'TP-UD').
		^deliverSM
			dataCoding: 0;
			shortMessage: bytes;
			yourself
	].
	
	(((tpdu at: 'TP-DCS') bitAnd: 2r1100) = 2r1000) ifTrue: [
		^deliverSM
			dataCoding: 8;
		shortMessage: (tpdu at: 'TP-UD');
		yourself
	].

	self reportUnhandled: tpdu.
	^nil