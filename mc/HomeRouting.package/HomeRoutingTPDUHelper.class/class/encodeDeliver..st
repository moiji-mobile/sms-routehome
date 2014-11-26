as yet unclassified
encodeDeliver: tpdu
	| hdr oa size data |
	size := (tpdu at: 'TP-OA') size.
	hdr := ((tpdu at: 'TP-RP') asBit) bitShift: 7.
	hdr := hdr bitOr: (((tpdu at: 'TP-UDHI') asBit) bitShift: 6).
	hdr := hdr bitOr: (((tpdu at: 'TP-SRI') asBit) bitShift: 5).
	hdr := hdr bitOr: (((tpdu at: 'TP-MMS') not asBit) bitShift: 2).
	hdr := hdr bitOr: (((tpdu at: 'TP-MTI')  bitAnd: 2r11) bitShift: 0).
	oa :=  {size. 2r10000000 bitOr: (((tpdu at: 'ton') bitShift: 4) bitOr: ((tpdu at: 'npi') bitAnd: 2r1111))}.
	oa := oa, (GSMNumberDigits encodeFrom: (tpdu at: 'TP-OA')) asByteArray.
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
		putByteArray: oa;
		putByte: (tpdu at: 'TP-PID');
		putByte: (tpdu at: 'TP-DCS');
		putByteArray: (tpdu at: 'TP-SCTS');
		putByte: (tpdu at: 'TP-UD-Len');
		putByteArray: data contents;
		toByteArray.
		