as yet unclassified
convertFromSMPPDeliverSM: deliverSM toSMS: result
	| dcs |

	dcs := deliverSM dataCoding.
	dcs = 0
		ifTrue: [HomeRoutingTPDUHelper formatToGSM7Bit: result on: deliverSM]
		ifFalse: [HomeRoutingTPDUHelper formatToOctets: result on: deliverSM].

	result at: 'TP-DCS' put: dcs.