as yet unclassified
smscAddress: aString with: anEncodedMSISDN
	^self new
		smscAddress: aString;
		encodedMSISDN: anEncodedMSISDN;
		yourself