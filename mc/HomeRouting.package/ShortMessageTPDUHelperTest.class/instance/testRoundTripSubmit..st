as yet unclassified
testRoundTripSubmit: anInput
	| extracted encoded |
	extracted := ShortMessageTPDUHelper extract: anInput.
	encoded := ShortMessageTPDUHelper encodeSubmit: extracted.
	self assert: encoded equals: anInput.
	