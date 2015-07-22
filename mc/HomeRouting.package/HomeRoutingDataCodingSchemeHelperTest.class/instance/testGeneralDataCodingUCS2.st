general-roundtrip
testGeneralDataCodingUCS2
	| res deliverSM conv |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> #[0 30].
		'TP-DCS' -> 2r1000.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	deliverSM registeredDelivery: 0.

	self assert: (HomeRoutingDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).
	self assert: deliverSM dataCoding equals: 2r1000.
	self assert: deliverSM shortMessage equals: #[0 30].
	self assert: (deliverSM esmClass bitShift: -6) equals: 2r00.

	conv := deliverSM toDeliverTPDUDictionary.
	self assert: (conv at: 'TP-DCS') equals: 2r1000.
	self deny: (conv at: 'TP-UDHI').