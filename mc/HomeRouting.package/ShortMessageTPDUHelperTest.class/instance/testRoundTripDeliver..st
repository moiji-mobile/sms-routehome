as yet unclassified
testRoundTripDeliver: anInput
	| extracted encoded |
	extracted := ShortMessageTPDUHelper extract: anInput.
	encoded := ShortMessageTPDUHelper encodeDeliver: extracted.
	self assert: encoded equals: anInput.
	