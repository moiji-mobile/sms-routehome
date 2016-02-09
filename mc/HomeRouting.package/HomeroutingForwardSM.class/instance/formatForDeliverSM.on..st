as yet unclassified
formatForDeliverSM: tpdu on: deliverSM
	"Depending on the TPDU we have to set the esmClass, dcs and either
	the short message."

	"We would need to set esmClass and look at the TP-UD front."
	(tpdu at: 'TP-RP')
		ifTrue: [self reportUnhandled: tpdu. ^nil].

	deliverSM
		esmClass: 0;
		protocolId: (tpdu at: 'TP-PID').		

	^(ShortMessageDataCodingSchemeHelper convertSMS: tpdu toDeliverSM: deliverSM)
		ifTrue: [deliverSM]
		ifFalse: [
			self reportUnhandled: tpdu.
			^nil]