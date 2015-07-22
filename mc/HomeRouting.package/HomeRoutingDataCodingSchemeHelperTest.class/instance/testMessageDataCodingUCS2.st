as yet unclassified
testMessageDataCodingUCS2
	| res deliverSM conv |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> #[10 20 30].
		'TP-UD-Len' -> 3.
		'TP-DCS' -> 2r11110101.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	deliverSM registeredDelivery: 0.

	self assert: (HomeRoutingDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).
	self assert: deliverSM dataCoding equals: 2r11110101.
	self assert: deliverSM shortMessage equals: #[10 20 30].
	self assert: (deliverSM esmClass bitShift: -6) equals: 2r00.

	conv := deliverSM toDeliverTPDUDictionary.
	self assert: (conv at: 'TP-DCS') equals: 2r11110101.
	self assert: (conv at: 'TP-UD') equals: #[10 20 30].