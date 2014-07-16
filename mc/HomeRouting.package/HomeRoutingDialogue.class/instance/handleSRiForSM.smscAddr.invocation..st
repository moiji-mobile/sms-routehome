sms
handleSRiForSM: aMSISDN smscAddr: aServiceCenter invocation: anInvocation
	| imsi |
	imsi := homeRoutingServer subscriberMap at: aMSISDN ifAbsent: [
			anInvocation returnError: 'unknownSubscriber' with: nil.
			self requestTcEnd: false.
			^false].

	anInvocation returnResultLast: (ASN1Dictionary new
					at: 'imsi' put: imsi toTBCD;
					at: 'locationInfoWithLMSI' put: (ASN1Dictionary new
							at: 'networkNode-Number' put: homeRoutingServer mscNumber toE164;
							yourself);
					yourself).
	self requestTcEnd: false.