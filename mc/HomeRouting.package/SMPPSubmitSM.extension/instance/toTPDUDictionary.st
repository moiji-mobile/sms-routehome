*HomeRouting-Core
toTPDUDictionary
	"Convert the SMPP body into a dictionary for encoding"
	| moreMessages hasUDH dcs data scts |
	hasUDH := ((esm_class bitAnd: 2r100000) bitShift: -5) > 0.
	moreMessages := false.
	more_messages_to_send ifNotNil: [
		"TODO: it might not be 0/1 here but actually a bytearray. Fix it in
		the SMPPCodec code"
		self notYetImplemented.
		more_messages_to_send = 1 ifTrue: [moreMessages := true]].

	dcs := data_coding.
	hasUDH  ifTrue: [self notYetImplemented].
	dcs = 0 ifFalse: [self notYetImplemented].
	data := short_message asGSM7Bit.

	scts := DateAndTime now asUTC asGSMSCTS.
	
	^Dictionary new
		at: 'TP-RP' put: false;
		at: 'TP-UDHI' put: hasUDH;
		at: 'TP-SRI' put: registered_delivery > 0;
		at: 'TP-MMS' put: moreMessages;
		at: 'TP-MTI' put: 0;
		at: 'ton' put: source_addr_ton;
		at: 'npi' put: source_addr_npi;
		at: 'TP-OA' put: source_addr;
		at: 'TP-PID' put: 0;
		at: 'TP-DCS' put: dcs;
		at: 'TP-SCTS' put: scts;
		at: 'TP-UD' put: data;
		at: 'TP-UD-Len' put: short_message size;
		yourself.