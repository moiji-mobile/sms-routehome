*HomeRouting-Core
toTPDUDictionary
	"Convert the SMPP body into a dictionary for encoding"
	| result moreMessages dcs scts |
	result := Dictionary new.
	moreMessages := false.

	more_messages_to_send ifNotNil: [
		"TODO: it might not be 0/1 here but actually a bytearray. Fix it in
		the SMPPCodec code"
		self notYetImplemented.
		more_messages_to_send = 1 ifTrue: [moreMessages := true]].

	dcs := data_coding.
	dcs = 0 ifFalse: [^self notYetImplemented].

	HomeRoutingTPDUHelper formatToGSM7Bit: result on: self.
	scts := DateAndTime now asUTC asGSMSCTS.
	
	^result
		at: 'TP-RP' put: false;
		at: 'TP-SRI' put: registered_delivery > 0;
		at: 'TP-MMS' put: moreMessages;
		at: 'TP-MTI' put: 0;
		at: 'ton' put: source_addr_ton;
		at: 'npi' put: source_addr_npi;
		at: 'TP-OA' put: source_addr;
		at: 'TP-PID' put: 0;
		at: 'TP-DCS' put: dcs;
		at: 'TP-SCTS' put: scts;
		yourself.