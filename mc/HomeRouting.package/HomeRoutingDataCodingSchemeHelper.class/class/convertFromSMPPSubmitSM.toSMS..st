as yet unclassified
convertFromSMPPSubmitSM: submitSM toSMS: result
	| dcs |

	dcs := submitSM dataCoding.
	dcs = 0
		ifTrue: [HomeRoutingTPDUHelper formatToGSM7Bit: result on: submitSM]
		ifFalse: [HomeRoutingTPDUHelper formatToOctets: result on: submitSM].

	result at: 'TP-DCS' put: dcs.