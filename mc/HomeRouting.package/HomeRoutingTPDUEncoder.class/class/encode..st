as yet unclassified
encode: tpdu
	| hdr |
	hdr := ((tpdu at: 'TP-RP') bitAnd: 2r1) bitShift: 7.
	hdr := hdr bitOr: (((tpdu at: 'TP-UDHI') bitAnd: 2r1) bitShift: 6).
	hdr := hdr bitOr: (((tpdu at: 'TP-SRI') bitAnd: 2r1) bitShift: 5).
	hdr := hdr bitOr: (((tpdu at: 'TP-MMS') bitAnd: 2r1) bitShift: 2).
	hdr := hdr bitOr: (((tpdu at: 'TP-MTI') bitAnd: 2r11) bitShift: 0).
	^ #[] toMessage
		putByte: hdr;
		putByteArray: (tpdu at: 'TP-OA');
		putByte: (tpdu at: 'TP-PID');
		putByte: (tpdu at: 'TP-DCS');
		putByteArray: (tpdu at: 'TP-SCTS');
		putByte: (tpdu at: 'TP-UDL');
		putByteArray: (tpdu at: 'TP-UD');
		yourself.
		