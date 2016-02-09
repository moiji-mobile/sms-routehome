general-impossible
testGeneralDataCodingMessageClass
	| res |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> '1234' asUSSD7Bit.
		'TP-UD-Len' -> 4.
		'TP-DCS' -> 2r00010000.  } asDictionary.

	"We can't map the message class. So verify we fail"
	self deny: (ShortMessageDataCodingSchemeHelper convertSMS: res toDeliverSM: SMPPDeliverSM new).