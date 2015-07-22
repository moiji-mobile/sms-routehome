as yet unclassified
convertSMS: tpdu toDeliverSM: deliverSM
	| dcs type |

	dcs := tpdu at: 'TP-DCS'.
	type := dcs bitShift: -4.

	(type bitAnd: 2r1100) = 0 ifTrue: [
		^self convertGeneralCoding: tpdu toDeliverSM: deliverSM].
	(type bitAnd: 2r1111) = 2r1100 ifTrue: [
		^self convertMessageWaitingIndication: tpdu toDeliverSM: deliverSM ucs2: false].
	(type bitAnd: 2r1111) = 2r1101 ifTrue: [
		^self convertMessageWaitingIndication: tpdu toDeliverSM: deliverSM ucs2: false].
	(type bitAnd: 2r1111) = 2r1110 ifTrue: [
		^self convertMessageWaitingIndication: tpdu toDeliverSM: deliverSM ucs2: true].
	(type bitAnd: 2r1111) = 2r1111 ifTrue: [
		^self convertDataCoding: tpdu toDeliverSM: deliverSM].
	^false