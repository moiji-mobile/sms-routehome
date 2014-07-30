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
		"The last 7bit of the TP-UD might be empty and this is why there is
		a TP-UD-Len so one can know if the last '0' belongs to the SMS or not.
		We need to truncate the byearray here and abuse a feature of Squeak
		at this point. To use >>#next:"
		bytes := GSMDecoding expand: (tpdu at: 'TP-UD').
		^deliverSM
			dataCoding: 0;
			shortMessage: (bytes readStream next: (tpdu at: 'TP-UD-Len'));
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