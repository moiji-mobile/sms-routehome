as yet unclassified
convertDataCoding: tpdu toDeliverSM: deliverSM
	| dcs |

	deliverSM esmClass: 0.
	dcs := tpdu at: 'TP-DCS'.
	(dcs bitAnd: 2r100) = 0
		ifTrue: [
			HomeRoutingTPDUHelper formatFromGSM7Bit: tpdu on: deliverSM.
			deliverSM dataCoding: dcs]
		ifFalse: [
			HomeRoutingTPDUHelper formatFromOctets: tpdu on: deliverSM.
			deliverSM dataCoding: dcs].
	^true