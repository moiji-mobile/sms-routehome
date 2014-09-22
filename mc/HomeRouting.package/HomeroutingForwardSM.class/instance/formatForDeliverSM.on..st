as yet unclassified
formatForDeliverSM: tpdu on: deliverSM
	| data |
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
		bytes := #[] toMessage.
		bytes
			putByteArray: data;
			putByteArray: (tpdu at: 'TP-UD').
		bytes := GSMDecoding expand: bytes.
		bytes := bytes readStream next: (tpdu at: 'TP-UD-Len').
		
		"With TP-UDHIand 7bit encoding there are some bytes we need to
		skip and re-do now."
		(tpdu at: 'TP-UDHI') ifTrue: [
			| skip fillBits |
			"Now we need to skip the n-octets of the header and maybe from
			the fill bit as well and put back the original data again."
			skip := (((data size)* 8) \\ 7).
			fillBits := 7 - skip.
			fillBits > 0
				ifTrue: [skip := skip + 1].

			data
				putByteArray: (bytes allButFirst: skip).
			bytes := data.
		].
		^deliverSM
			dataCoding: 0;
			shortMessage: bytes asByteArray;
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