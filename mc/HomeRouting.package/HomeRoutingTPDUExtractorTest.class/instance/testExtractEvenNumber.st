as yet unclassified
testExtractEvenNumber
	| inp extracted |
	inp := ByteArray readHexFrom: '240c9153345800109100004170031102950012d4f29c0e32cbdf6dd0d3ddba87ede539'.
	extracted := HomeRoutingTPDUExtractor extract: inp.
	self assert: (extracted at: 'TP-RP') equals: false.
	self assert: (extracted at: 'TP-UDHI') equals: false.
	self assert: (extracted at: 'TP-SRI') equals: true.
	self assert: (extracted at: 'TP-MMS') equals: true.
	self assert: (extracted at: 'TP-MTI') equals: 0.

	self assert: (extracted at: 'npi') equals: 1.
	self assert: (extracted at: 'ton') equals: 1.
	self assert: (extracted at: 'TP-OA') equals: '354385000119'.
	self assert: (extracted at: 'TP-DCS') equals: 0.
	self assert: (extracted at: 'TP-SCTS') equals: #[65 112 3 17 2 149 0].
	self assert: (extracted at: 'TP-UD') equals: #[212 242 156 14 50 203 223 109 208 211 221 186 135 237 229 57].
	self assert: (extracted at: 'TP-UD-Len') equals: 18.