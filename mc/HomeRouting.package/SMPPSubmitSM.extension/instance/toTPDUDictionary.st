*HomeRouting-Core
toTPDUDictionary
	"Convert the SMPP body into a dictionary for encoding"
	| oa moreMessages hasUDH dcs data scts |
	oa := (2r10000000 bitOr: ((source_addr_ton bitAnd: 2r111) bitShift: 4)) bitOr: (source_addr_npi bitAnd: 2r1111).
	oa := ({source_addr size. oa}, (GSMNumberDigits encodeFrom: source_addr)) asByteArray.
	hasUDH := (esm_class bitAnd: 2r100000) bitShift: -5.
	moreMessages := 1.
	more_messages_to_send ifNotNil: [
		"TODO: it might not be 0/1 here but actually a bytearray. Fix it in
		the SMPPCodec code"
		self notYetImplemented.
		more_messages_to_send = 1 ifTrue: [moreMessages := 0]].

	dcs := data_coding.
	hasUDH > 0 ifTrue: [self notYetImplemented].
	dcs = 0 ifFalse: [self notYetImplemented].
	data := short_message asGSM7Bit.

	scts := DateAndTime now asUTC asGSMSCTS.
	
	^Dictionary new
		at: 'TP-RP' put: 0;
		at: 'TP-UDHI' put: hasUDH;
		at: 'TP-SRI' put: registered_delivery;
		at: 'TP-MMS' put: moreMessages;
		at: 'TP-MTI' put: 0;
		at: 'TP-OA' put: oa;
		at: 'TP-PID' put: 0;
		at: 'TP-DCS' put: dcs;
		at: 'TP-SCTS' put: scts;
		at: 'TP-UD' put: data;
		at: 'TP-UDL' put: short_message size;
		yourself.