as yet unclassified
testExtract
	| inp extracted |
	inp := #[4 11 145 51 102 2 19 69 244 0 0 65 112 113 129 4 113 128 6 210 114 185 92 70 3].
	extracted := HomeRoutingTPDUHelper extract: inp.
	self assert: (extracted at: 'TP-RP') equals: false.
	self assert: (extracted at: 'TP-UDHI') equals: false.
	self assert: (extracted at: 'TP-SRI') equals: false.
	self deny: (extracted at: 'TP-MMS').
	self assert: (extracted at: 'TP-MTI') equals: 0.

	self assert: (extracted at: 'npi') equals: 1.
	self assert: (extracted at: 'ton') equals: 1.
	self assert: (extracted at: 'TP-OA') equals: '33662031544'.
	self assert: (extracted at: 'TP-DCS') equals: 0.
	self assert: (extracted at: 'TP-SCTS') equals: #[16r41 16r70 16r71 16r81 16r04 16r71 16r80].
	self assert: (extracted at: 'TP-UD') equals: #[16rD2 16r72 16rB9 16r5C 16r46 16r03].