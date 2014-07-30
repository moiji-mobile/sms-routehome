as yet unclassified
extract: aByteArray
	| res stream byte len data ton_npi |
	res := Dictionary new.
	stream := aByteArray readStream.
	byte := stream next.
	
	"Read the header"
	res at: 'TP-MTI' put: (byte bitAnd: 2r11).
	res at: 'TP-MMS' put: (byte bitAnd: 2r100) >0.
	res at: 'TP-SRI' put: (byte bitAnd:  2r100000) > 0.
	res at: 'TP-UDHI' put: (byte bitAnd: 2r1000000) > 0.
	res at: 'TP-RP' put: (byte bitAnd: 2r10000000) > 0.

	"Read the address and assume it is TBCD"
	len := stream next.
	ton_npi := stream next.
	res at: 'ton' put: ((ton_npi bitShift: -4) bitAnd: 2r111).
	res at: 'npi' put: (ton_npi bitAnd: 2r1111).
	len := ((len + 1) / 2) asInteger.
	data := stream next: len.
	data size = len
		ifFalse: [^self error: 'Short Read on Pharo'].
	res at: 'TP-OA' put: (GSMNumberDigits decodeFrom: data).

	"Read TP-PID/TP-DCS/TP-SCTS"
	res at: 'TP-PID' put: stream next.
	res at: 'TP-DCS' put: stream next.
	data := stream next: 7.
	(data size = 7)
		ifFalse: [^self error: 'Short Read on Pharo'].
	res at: 'TP-SCTS' put: data.
	
	len := stream next.
	res at: 'TP-UD-Len' put: len.
	data := stream upToEnd.
	res at: 'TP-UD' put: data.
	^res