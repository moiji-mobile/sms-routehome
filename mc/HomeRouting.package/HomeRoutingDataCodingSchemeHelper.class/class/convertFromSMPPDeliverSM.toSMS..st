as yet unclassified
convertFromSMPPDeliverSM: deliverSM toSMS: result
	| dcs |

	dcs := deliverSM dataCoding.
	dcs = 0 ifTrue: [
		result at: 'TP-DCS' put: 0.
		^HomeRoutingTPDUHelper formatToGSM7Bit: result on: deliverSM].
	dcs = 1 ifTrue: [
		result at: 'TP-DCS' put: 2r0100.
		^HomeRoutingTPDUHelper formatToOctets: result on: deliverSM].
	dcs = 2r1000 ifTrue: [
		result at: 'TP-DCS' put: 2r1000.
		^HomeRoutingTPDUHelper formatToOctets: result on: deliverSM].

	"Assume 1:1 mapping.."
	result at: 'TP-DCS' put: dcs.
	^HomeRoutingTPDUHelper formatToOctets: result on: deliverSM.