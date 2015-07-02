as yet unclassified
testExtractOddAlphanumeric
	| extracted |
	extracted := HomeRoutingTPDUHelper extract: #[4 9 208 243 117 30 94 6 0 0 81 112 32 33 149 101 0 31 237 48 157 158 14 207 217 117 55 121 78 151 191 203 109 157 130 90 158 211 65 205 48 157 158 14 207 1].

	self assert: (extracted at: 'npi') equals: 0.
	self assert: (extracted at: 'ton') equals: 5.
	self assert: (extracted at: 'TP-OA') equals: 'skype'.
