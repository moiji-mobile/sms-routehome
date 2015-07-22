as yet unclassified
convertFromSMPPSubmitSM: submitSM toSMS: result
	"SubmitSM would be able to express more so let's fallback
	to a subset of what we could do"
	^self convertFromSMPPDeliverSM: submitSM toSMS: result.