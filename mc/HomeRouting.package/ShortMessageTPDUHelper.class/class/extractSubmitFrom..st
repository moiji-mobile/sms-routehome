as yet unclassified
extractSubmitFrom: stream
	| byte res data udhi len addr |

	res := Dictionary new.
	byte := stream next.
	
	"Read the header"
	res at: 'TP-MTI' put: (byte bitAnd: 2r11).
	res at: 'TP-RD' put: (byte bitAnd: 2r100)  = 0.
	res at: 'TP-VPFI' put: ((byte bitAnd:  2r11000) bitShift: -3).
	res at: 'TP-SRR' put: (byte bitAnd: 2r100000) > 0.
	udhi := (byte bitAnd: 2r1000000) > 0.
	res at: 'TP-UDHI' put: udhi.
	res at: 'TP-RP' put: (byte bitAnd: 2r10000000) > 0.

	res at: 'TP-MR' put: stream next.

	"Read the address and assume it is TBCD"
	addr := GSMAddressCoding decodeSMSAddress: stream.
	res
		at: 'ton' put: addr typeOfNumber;
		at: 'npi' put: addr numberingPlan;
		at: 'TP-DA' put: addr address.

	"Read TP-PID/TP-DCS"
	res at: 'TP-PID' put: stream next.
	res at: 'TP-DCS' put: stream next.

	(res at: 'TP-VPFI') = 2 ifTrue: [
		res at: 'TP-VP' put: (stream next: 1)].
	
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