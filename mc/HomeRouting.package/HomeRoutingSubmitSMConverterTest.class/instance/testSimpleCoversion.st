as yet unclassified
testSimpleCoversion
	| deliverSM tpdu binary |
	deliverSM := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	tpdu := deliverSM body toDeliverTPDUDictionary.
	self deny: (tpdu at: 'TP-RP').
	self deny: (tpdu at: 'TP-UDHI').
	self assert: (tpdu at: 'TP-SRI').
	self deny: (tpdu at: 'TP-MMS').
	self assert: (tpdu at: 'TP-MTI') equals: 0.
	self assert: (tpdu at: 'TP-OA') equals: '888817024782276'.
	self assert: (tpdu at: 'ton') equals: 1.
	self assert: (tpdu at: 'npi') equals: 1.
	self assert: (tpdu at: 'TP-PID') equals: 0.
	self assert: (tpdu at: 'TP-DCS') equals: 0.
	self deny: (tpdu at: 'TP-SCTS') isNil.
	self assert: (tpdu at: 'TP-UD') equals: #[244 242 156 14 138 201 116 176 25].
	self assert: (tpdu at: 'TP-UD-Len') equals: 10.

	binary := ShortMessageTPDUHelper encodeDeliver: tpdu.