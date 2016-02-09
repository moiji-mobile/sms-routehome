as yet unclassified
convertFromSMPPDeliverSM: deliverSM toSMS: result
	| dcs type |

	dcs := deliverSM dataCoding.
	dcs = 0 ifTrue: [
		result at: 'TP-DCS' put: 0.
		^ShortMessageTPDUHelper formatToGSM7Bit: result on: deliverSM].
	dcs = 1 ifTrue: [
		result at: 'TP-DCS' put: 2r0100.
		^ShortMessageTPDUHelper formatToOctets: result on: deliverSM].
	dcs = 2r1000 ifTrue: [
		result at: 'TP-DCS' put: 2r1000.
		^ShortMessageTPDUHelper formatToOctets: result on: deliverSM].

	"Message Waiting Indication"
	type := (dcs bitShift: -4) bitAnd: 2r1111.
	(#(2r1100 2r1101) includes: type) ifTrue: [
		| res |
		res := ShortMessageTPDUHelper formatToGSM7Bit: result on: deliverSM.
		result at: 'TP-DCS' put: dcs.
		^res].

	"Data Coding Message"
	type = 2r1111 ifTrue: [
		(dcs bitAnd: 2r100) = 0 ifTrue: [
			| res |
			res := ShortMessageTPDUHelper formatToGSM7Bit: result on: deliverSM.
			result at: 'TP-DCS' put: dcs.
			^res]].

	"Assume 1:1 mapping.."
	result at: 'TP-DCS' put: dcs.
	^ShortMessageTPDUHelper formatToOctets: result on: deliverSM.