as yet unclassified
convertMessageWaitingIndication: tpdu toDeliverSM: deliverSM ucs2: useUCS2
	| dcs |

	dcs := tpdu at: 'TP-DCS'.
	deliverSM esmClass: 0.
	useUCS2
		ifTrue: [
			HomeRoutingTPDUHelper formatFromOctets: tpdu on: deliverSM.
			deliverSM dataCoding: dcs]
		ifFalse: [
			HomeRoutingTPDUHelper formatFromGSM7Bit: tpdu on: deliverSM.
			deliverSM dataCoding: dcs].

	^true