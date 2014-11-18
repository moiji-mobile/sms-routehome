as yet unclassified
testExtractSubmit
	| inp extracted |
	inp := #[1 12 15 129 0 148 81 135 134 120 70 245 0 0 9 204 183 189 12 202 191 235 32].
	extracted := HomeRoutingTPDUHelper extract: inp.
	self assert: (extracted at: 'TP-RP') equals: false.
	self assert: (extracted at: 'TP-UDHI') equals: false.
	self assert: (extracted at: 'TP-SRR') equals: false.
	self assert: (extracted at: 'TP-VPFI') equals: 0.
	self assert: (extracted at: 'TP-RD') equals: true.
	self assert: (extracted at: 'TP-MTI') equals: 1.
	self assert: (extracted at: 'TP-MR') equals: 12.

	self assert: (extracted at: 'npi') equals: 1.
	self assert: (extracted at: 'ton') equals: 0.
	self assert: (extracted at: 'TP-DA') equals: '004915786887645'.
	self assert: (extracted at: 'TP-DCS') equals: 0.
	self assert: (extracted at: 'TP-UD') equals: #[204 183 189 12 202 191 235 32].