sms
handleSRiForSM: aMSISDN smscAddr: aServiceCenter invocation: anInvocation ifAbsent: aBlock
	| aSubscriber smppConnection |
	aSubscriber := hlr database findMSISDN: aMSISDN.
	aSubscriber ifNil: [
			self logError: ('ID(<1p>) HomeRoutingDialogue no subscriber MSISDN(<2s>) '
							expandMacrosWith: self id with: aMSISDN) area: #home.
			anInvocation returnError: 'unknownSubscriber' with: nil.
			self requestTcEnd: false.
			^false].

	"Is there a SMPP connection?"
	smppConnection := hlr selectSMPPConnection.
	smppConnection ifNil: [
		self logError: ('ID(<1p>) HomeRoutingDialogue no subscriber SMPP connection IMSI(<2s>) '
						expandMacrosWith: self id with: aSubscriber imsi) area: #home.
		aBlock value.
		^false
	].

	self logDebug: ('ID(<1p>) Responding with IMSI(<2s>) for MSISDN(<3s>)'
							expandMacrosWith: self id with: aSubscriber imsi with: aMSISDN) area: #home.
	anInvocation returnResultLast: (ASN1Dictionary new
					at: 'imsi' put: aSubscriber imsi toTBCD;
					at: 'locationInfoWithLMSI' put: (ASN1Dictionary new
							at: 'networkNode-Number' put: hlr mscNumber toE164;
							yourself);
					yourself).
	self requestTcEnd: false.