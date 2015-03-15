as yet unclassified
encodeDeliver: tpdu
	| hdr data addr |
	hdr := ((tpdu at: 'TP-RP') asBit) bitShift: 7.
	hdr := hdr bitOr: (((tpdu at: 'TP-UDHI') asBit) bitShift: 6).
	hdr := hdr bitOr: (((tpdu at: 'TP-SRI') asBit) bitShift: 5).
	hdr := hdr bitOr: (((tpdu at: 'TP-MMS') not asBit) bitShift: 2).
	hdr := hdr bitOr: (((tpdu at: 'TP-MTI')  bitAnd: 2r11) bitShift: 0).
	addr := GSMAddress new
				typeOfNumber: (tpdu at: 'ton');
				numberingPlan: (tpdu at: 'npi');
				address: (tpdu at: 'TP-OA');
				yourself.
	data := WriteStream on: ByteArray new.
	(tpdu at: 'TP-UDHI') ifTrue: [
		| udh |
		udh := tpdu at: 'TP-UDH'.
		data
			nextPut: udh size;
			nextPutAll: udh].
	data nextPutAll: (tpdu at: 'TP-UD').
	^ #[] toMessage
		putByte: hdr;
		putByteArray: addr encodeSMSAddress;
		putByte: (tpdu at: 'TP-PID');
		putByte: (tpdu at: 'TP-DCS');
		putByteArray: (tpdu at: 'TP-SCTS');
		putByte: (tpdu at: 'TP-UD-Len');
		putByteArray: data contents;
		toByteArray.
		