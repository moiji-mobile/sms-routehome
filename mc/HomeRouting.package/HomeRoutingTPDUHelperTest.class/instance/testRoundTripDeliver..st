as yet unclassified
testRoundTripDeliver: anInput
	| extracted encoded |
	extracted := HomeRoutingTPDUHelper extract: anInput.
	encoded := HomeRoutingTPDUHelper encodeDeliver: extracted.
	self assert: encoded equals: anInput.
	