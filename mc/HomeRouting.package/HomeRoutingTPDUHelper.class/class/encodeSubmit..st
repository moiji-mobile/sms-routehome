as yet unclassified
encodeSubmit: tpdu
	| hdr da size data |
	size := (tpdu at: 'TP-DA') size.
	hdr := ((tpdu at: 'TP-RP') asBit) bitShift: 7.
	hdr := hdr bitOr: (((tpdu at: 'TP-UDHI') asBit) bitShift: 6).
	hdr := hdr bitOr: (((tpdu at: 'TP-SRR') asBit) bitShift: 5).
	hdr := hdr bitOr: (((tpdu at: 'TP-VPFI') bitAnd: 2r11) bitShift: 3).
	hdr := hdr bitOr: (((tpdu at: 'TP-RD') not asBit) bitShift: 2).
	hdr := hdr bitOr: (((tpdu at: 'TP-MTI')  bitAnd: 2r11) bitShift: 0).
	
	da :=  {size. 2r10000000 bitOr: (((tpdu at: 'ton') bitShift: 4) bitOr: ((tpdu at: 'npi') bitAnd: 2r1111))}.
	da := da, (GSMNumberDigits encodeFrom: (tpdu at: 'TP-DA')) asByteArray.
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
		putByte: (tpdu at: 'TP-MR');
		putByteArray: da;
		putByte: (tpdu at: 'TP-PID');
		putByte: (tpdu at: 'TP-DCS');
		putByte: (tpdu at: 'TP-UD-Len');
		putByteArray: data contents;
		toByteArray.
		