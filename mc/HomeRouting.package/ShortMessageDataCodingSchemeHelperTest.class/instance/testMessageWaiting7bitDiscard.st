as yet unclassified
testMessageWaiting7bitDiscard
	| res deliverSM conv |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> '1234' asUSSD7Bit.
		'TP-UD-Len' -> 4.
		'TP-DCS' -> 2r11001010.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	deliverSM registeredDelivery: 0.

	self assert: (ShortMessageDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).
	self assert: deliverSM dataCoding equals: 2r11001010.
	self assert: deliverSM shortMessage equals: '1234' asByteArray.
	self assert: (deliverSM esmClass bitShift: -6) equals: 2r00.

	conv := deliverSM toDeliverTPDUDictionary.
	self assert: (conv at: 'TP-DCS') equals: 2r11001010.