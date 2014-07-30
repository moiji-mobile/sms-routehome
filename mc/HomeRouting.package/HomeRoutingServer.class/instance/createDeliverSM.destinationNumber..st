smpp
createDeliverSM: anInvocation destinationNumber: destinationNumber
	| deliverSM  tpdu |
	
	"Extract information from the deliverSM"
	[
		| string |
		"Work around ASN1PrimtiveCodec>>#decodeOctetString issue that throws away the
		first character if it is 0. The issue has been reported by mail on the 29th of July 2014."
		string := anInvocation argument sm_RP_UI.
		string size odd
			ifTrue: [string := '0', string].
		tpdu := HomeRoutingTPDUExtractor extract: (ByteArray readHexFrom: string).
	] on: Error do: [:err |
		err logException: ('Dest(<1s>) couldn''t parse TPDU' expandMacrosWith: destinationNumber) area: #home.
		^nil
	].

	deliverSM := SMPPDeliverSM new.
	deliverSM
		serviceType: '';
		sourceTypeOfNumber: (tpdu at: 'ton');
		sourceNumberingPlanIndicator: (tpdu at: 'npi');
		sourceAddress: (tpdu at: 'TP-OA');
		destinationTypeOfNumber: 1;
		destinationNumberingPlanIndicator: 1;
		destinationAddress: destinationNumber;
		priorityLevel: 0;
		scheduleDeliveryTime: '';
		validityPeriod: '';
		registeredDelivery: 0;
		dontReplaceIfPresent;
		defaultMessageID: 0;
		yourself.

	^ self formatForDeliverSM: tpdu on: deliverSM.