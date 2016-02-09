as yet unclassified
extractDeliverFrom: stream
	| byte res data udhi len addr |
	res := Dictionary new.
	byte := stream next.
	
	"Read the header"
	res at: 'TP-MTI' put: (byte bitAnd: 2r11).
	res at: 'TP-MMS' put: (byte bitAnd: 2r100) = 0.
	res at: 'TP-SRI' put: (byte bitAnd:  2r100000) > 0.
	udhi := (byte bitAnd: 2r1000000) > 0.
	res at: 'TP-UDHI' put: udhi.
	res at: 'TP-RP' put: (byte bitAnd: 2r10000000) > 0.

	"Read the address"
	addr := GSMAddressCoding decodeSMSAddress: stream.
	res
		at: 'ton' put: addr typeOfNumber;
		at: 'npi' put: addr numberingPlan;
		at: 'TP-OA' put: addr address.

	"Read TP-PID/TP-DCS/TP-SCTS"
	res at: 'TP-PID' put: stream next.
	res at: 'TP-DCS' put: stream next.
	data := stream next: 7.
	(data size = 7)
		ifFalse: [^self error: 'Short Read on Pharo'].
	res at: 'TP-SCTS' put: data.
	
	len := stream next.
	res at: 'TP-UD-Len' put: len.
	udhi ifTrue: [
		len := stream next.
		data := stream next: len.
		(data size = len)
			ifFalse: [^self error: 'Short Read on Pharo'].
		res at: 'TP-UDH' put: data.
	].
	data := stream upToEnd.
	res at: 'TP-UD' put: data.
	^res