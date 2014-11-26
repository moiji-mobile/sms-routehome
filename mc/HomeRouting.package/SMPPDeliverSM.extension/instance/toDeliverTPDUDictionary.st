*HomeRouting-Core
toDeliverTPDUDictionary
	"Convert the SMPP body into a dictionary for encoding"
	| result dcs scts |
	result := Dictionary new.

	dcs := data_coding.
	dcs = 0 ifFalse: [^self notYetImplemented].

	HomeRoutingTPDUHelper formatToGSM7Bit: result on: self.
	scts := DateAndTime now asUTC asGSMSCTS.
	
	^result
		at: 'TP-RP' put: false;
		at: 'TP-SRI' put: registered_delivery > 0;
		at: 'TP-MMS' put: false;
		at: 'TP-MTI' put: 0;
		at: 'ton' put: source_addr_ton;
		at: 'npi' put: source_addr_npi;
		at: 'TP-OA' put: source_addr;
		at: 'TP-PID' put: 0;
		at: 'TP-DCS' put: dcs;
		at: 'TP-SCTS' put: scts;
		yourself.