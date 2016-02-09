*HomeRouting-Core
toDeliverTPDUDictionary
	"Convert the SMPP body into a dictionary for encoding"
	| result  scts |
	result := Dictionary new.

	ShortMessageDataCodingSchemeHelper convertFromSMPPDeliverSM: self toSMS: result.
	scts := DateAndTime now asUTC asGSMSCTS.
	
	^result
		at: 'TP-RP' put: false;
		at: 'TP-SRI' put: registered_delivery > 0;
		at: 'TP-MMS' put: false;
		at: 'TP-MTI' put: 0;
		at: 'ton' put: source_addr_ton;
		at: 'npi' put: source_addr_npi;
		at: 'TP-OA' put: source_addr;
		at: 'TP-PID' put: protocol_id;
		at: 'TP-SCTS' put: scts;
		yourself.