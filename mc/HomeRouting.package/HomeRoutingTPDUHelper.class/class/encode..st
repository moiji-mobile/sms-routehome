as yet unclassified
encode: tpdu
	| hdr oa size |
	size := (tpdu at: 'TP-OA') size.
	hdr := ((tpdu at: 'TP-RP') asBit) bitShift: 7.
	hdr := hdr bitOr: (((tpdu at: 'TP-UDHI') asBit) bitShift: 6).
	hdr := hdr bitOr: (((tpdu at: 'TP-SRI') asBit) bitShift: 5).
	hdr := hdr bitOr: (((tpdu at: 'TP-MMS') not asBit) bitShift: 2).
	hdr := hdr bitOr: (((tpdu at: 'TP-MTI')  bitAnd: 2r11) bitShift: 0).
	oa :=  {size. 2r10000000 bitOr: (((tpdu at: 'ton') bitShift: 4) bitOr: ((tpdu at: 'npi') bitAnd: 2r1111))}.
	oa := oa, (GSMNumberDigits encodeFrom: (tpdu at: 'TP-OA')) asByteArray.
	^ #[] toMessage
		putByte: hdr;
		putByteArray: oa;
		putByte: (tpdu at: 'TP-PID');
		putByte: (tpdu at: 'TP-DCS');
		putByteArray: (tpdu at: 'TP-SCTS');
		putByte: (tpdu at: 'TP-UD-Len');
		putByteArray: (tpdu at: 'TP-UD');
		toByteArray.
		