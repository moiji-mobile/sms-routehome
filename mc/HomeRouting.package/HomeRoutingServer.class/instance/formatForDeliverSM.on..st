smpp
formatForDeliverSM: tpdu on: deliverSM
	| data  |
	"Depending on the TPDU we have to set the esmClass, dcs and either
	the short message."


	"We would need to set esmClass and look at the TP-UD front."
	(tpdu at: 'TP-RP')
		ifTrue: [self reportUnhandled: tpdu. ^nil].

	data := #[] toMessage.
	deliverSM
		esmClass: 0;
		protocolId: 0.		

	(tpdu at: 'TP-UDHI') ifTrue: [
		| udh |
		"Indicate we have a UDH here and assume we know the rest of the class"
		udh := (tpdu at: 'TP-UDH').
		deliverSM esmClass: 2r01000000.
		data
			putByte: udh size;
			putByteArray: udh.
	].

	"Look at the DCS of the message"
	(tpdu at: 'TP-DCS') = 0 ifTrue: [
		| bytes |
		"The last 7bit of the TP-UD might be empty and this is why there is
		a TP-UD-Len so one can know if the last '0' belongs to the SMS or not.
		We need to truncate the bytearray here and abuse a feature of Squeak
		at this point. To use >>#next:"
		bytes := GSMDecoding expand: (tpdu at: 'TP-UD').
		data putByteArray: bytes.
		data := data asByteArray readStream next: (tpdu at: 'TP-UD-Len').
		^deliverSM
			dataCoding: 0;
			shortMessage: data asByteArray;
			yourself
	].
	
	(((tpdu at: 'TP-DCS') bitAnd: 2r1100) = 2r1000) ifTrue: [
		data putByteArray: (tpdu at: 'TP-UD').
		^deliverSM
			dataCoding: 8;
			shortMessage: data asByteArray;
			yourself
	].

	self reportUnhandled: tpdu.
	^nil