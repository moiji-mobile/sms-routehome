as yet unclassified
testRoundTripSubmit: anInput
	| extracted encoded |
	extracted := HomeRoutingTPDUHelper extract: anInput.
	encoded := HomeRoutingTPDUHelper encodeSubmit: extracted.
	self assert: encoded equals: anInput.
	