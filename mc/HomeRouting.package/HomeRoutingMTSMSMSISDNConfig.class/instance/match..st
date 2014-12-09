as yet unclassified
match: aSmppMessage
	| body |
	body := aSmppMessage body.
	^(sourceMsisdnMatch matches: body sourceAddress)
		and: [(destinationMsisdnMatch matches: body destinationAddress)].