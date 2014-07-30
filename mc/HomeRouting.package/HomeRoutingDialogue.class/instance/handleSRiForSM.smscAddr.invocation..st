sms
handleSRiForSM: aMSISDN smscAddr: aServiceCenter invocation: anInvocation
	| imsi |
	imsi := homeRoutingServer subscriberMap at: aMSISDN ifAbsent: [
			self logError: ('ID(<1s>) HomeRoutingDialogue no subscriber MSISDN(<2s>) '
							expandMacrosWith: self id with: aMSISDN) area: #home.
			anInvocation returnError: 'unknownSubscriber' with: nil.
			self requestTcEnd: false.
			^false].

	self logDebug: ('ID(<1s>) Responding with IMSI(<2s>) for MSISDN(<3s>)'
							expandMacrosWith: self id with: imsi with: aMSISDN) area: #home.
	anInvocation returnResultLast: (ASN1Dictionary new
					at: 'imsi' put: imsi toTBCD;
					at: 'locationInfoWithLMSI' put: (ASN1Dictionary new
							at: 'networkNode-Number' put: homeRoutingServer mscNumber toE164;
							yourself);
					yourself).
	self requestTcEnd: false.