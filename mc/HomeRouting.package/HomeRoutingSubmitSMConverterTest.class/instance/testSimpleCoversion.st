as yet unclassified
testSimpleCoversion
	| submitSM tpdu binary |
	submitSM := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream.
	tpdu := submitSM body toTPDUDictionary.
	self deny: (tpdu at: 'TP-RP').
	self deny: (tpdu at: 'TP-UDHI').
	self deny: (tpdu at: 'TP-SRI').
	self deny: (tpdu at: 'TP-MMS').
	self assert: (tpdu at: 'TP-MTI') equals: 0.
	self assert: (tpdu at: 'TP-OA') equals: '9225001'.
	self assert: (tpdu at: 'ton') equals: 1.
	self assert: (tpdu at: 'npi') equals: 1.
	self assert: (tpdu at: 'TP-PID') equals: 0.
	self assert: (tpdu at: 'TP-DCS') equals: 0.
	self deny: (tpdu at: 'TP-SCTS') isNil.
	self assert: (tpdu at: 'TP-UD') equals: #[196 116 121 14 74 207 233 160 114 218 93 6 81 203 115 186 59 60 70 203 211 99 52 61 4 2 201 96 49 90 11 54 107 193 98 223 152 205 69 131 185 104 50].
	self assert: (tpdu at: 'TP-UD-Len') equals: 49.

	binary := HomeRoutingTPDUHelper encode: tpdu.