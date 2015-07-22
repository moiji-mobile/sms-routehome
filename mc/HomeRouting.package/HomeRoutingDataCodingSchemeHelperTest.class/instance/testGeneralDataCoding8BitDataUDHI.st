general-roundtrip
testGeneralDataCoding8BitDataUDHI
	| res deliverSM conv |
	res := {
		'TP-UDHI' -> true.
		'TP-UDH' -> #[9 8 7 6].
		'TP-UD' -> #[30 29 28].
		'TP-DCS' -> 2r0100.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	deliverSM registeredDelivery: 0.

	self assert: (HomeRoutingDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).
	self assert: deliverSM dataCoding equals: 2r01.
	self assert: deliverSM shortMessage equals: #[4 9 8 7 6 30 29 28].
	self assert: (deliverSM esmClass bitShift: -6) equals: 2r01.

	conv := deliverSM toDeliverTPDUDictionary.
	self assert: (conv at: 'TP-UDHI').
	self assert: (conv at: 'TP-UDH') equals: #[9 8 7 6].
	self assert: (conv at: 'TP-UD') equals: #[30 29 28].
	self assert: (conv at: 'TP-UD-Len') equals: 8.
	self assert: (conv at: 'TP-DCS') equals: 2r0100.