sms
handleSRiForSM: aMSISDN smscAddr: aServiceCenter invocation: anInvocation
	| imsi |
	imsi := homeRoutingServer subscriberMap at: aMSISDN ifAbsent: [
			self logError: 'HomeRoutingDialogue no subscriber for: ', aMSISDN area: #home.
			anInvocation returnError: 'unknownSubscriber' with: nil.
			self requestTcEnd: false.
			^false].

	self logDebug: ('Responding with IMSI(<1s>) for MSISDN(<2s>)' expandMacrosWith: imsi with: aMSISDN) area: #home.
	anInvocation returnResultLast: (ASN1Dictionary new
					at: 'imsi' put: imsi toTBCD;
					at: 'locationInfoWithLMSI' put: (ASN1Dictionary new
							at: 'networkNode-Number' put: homeRoutingServer mscNumber toE164;
							yourself);
					yourself).
	self requestTcEnd: false.