general-impossible
testGeneralDataCodingReserved
	| res deliverSM |
	res := {
		'TP-UDHI' -> false.
		'TP-UD' -> #[0 30].
		'TP-DCS' -> 2r1100.  } asDictionary.

	"Verify 8bit data is mapped correctly"
	deliverSM := SMPPDeliverSM new.
	self deny: (HomeRoutingDataCodingSchemeHelper convertSMS: res toDeliverSM: deliverSM).