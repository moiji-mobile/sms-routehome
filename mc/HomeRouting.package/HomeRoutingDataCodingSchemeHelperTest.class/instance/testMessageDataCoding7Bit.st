as yet unclassified
testMessageDataCoding7Bit
	| res deliverSM conv |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> '123' asUSSD7Bit.
		'TP-UD-Len' -> 3.
		'TP-DCS' -> 2r11110001.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	deliverSM registeredDelivery: 0.

	self assert: (HomeRoutingDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).
	self assert: deliverSM dataCoding equals: 2r11110001.
	self assert: deliverSM shortMessage equals: '123' asByteArray.
	self assert: (deliverSM esmClass bitShift: -6) equals: 2r00.

	conv := deliverSM toDeliverTPDUDictionary.
	self assert: (conv at: 'TP-DCS') equals: 2r11110001.
	self assert: (conv at: 'TP-UD') equals: '123' asUSSD7Bit.