as yet unclassified
convertGeneralCoding: tpdu toDeliverSM: deliverSM 
	| dcs |
	dcs := tpdu at: 'TP-DCS'.

	deliverSM esmClass: 0.
	
	"Compression is used?"
	(dcs bitAnd: 2r100000) > 0 ifTrue: [
		"Compression is not easily expressable? Skip it"
		^false].

	"Treat 7bit differently"
	(dcs bitAnd: 2r1100) = 2r0000 ifTrue: [
		HomeRoutingTPDUHelper formatFromGSM7Bit: tpdu on: deliverSM].
	(dcs bitAnd: 2r1100) = 2r0100 ifTrue: [
		deliverSM dataCoding: 2r01.
		HomeRoutingTPDUHelper formatFromOctets: tpdu on: deliverSM].
	(dcs bitAnd: 2r1100) = 2r1000 ifTrue: [
		deliverSM dataCoding: 2r1000.
		HomeRoutingTPDUHelper formatFromOctets: tpdu on: deliverSM].
	(dcs bitAnd: 2r1100) = 2r1100 ifTrue: [
		"Reserved.."
		^false].

	"We can not map this to a SMPP DeliverSM"
	(dcs bitAnd: 2r10000) > 0 ifTrue: [
		^false].

	^true