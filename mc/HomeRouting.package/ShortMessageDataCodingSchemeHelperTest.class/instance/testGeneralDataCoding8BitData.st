general-roundtrip
testGeneralDataCoding8BitData
	| res deliverSM conv |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> '1234' asByteArray.
		'TP-DCS' -> 2r0100.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	deliverSM registeredDelivery: 0.

	self assert: (ShortMessageDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).
	self assert: deliverSM dataCoding equals: 2r01.
	self assert: deliverSM shortMessage equals: '1234' asByteArray.
	self assert: (deliverSM esmClass bitShift: -6) equals: 2r00.

	conv := deliverSM toDeliverTPDUDictionary.
	self assert: (conv at: 'TP-DCS') equals: 2r0100.