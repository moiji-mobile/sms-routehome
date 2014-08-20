as yet unclassified
handleSMDeliveryStatus: aMSISDN invocation: anInvocation operation: anOperationName
	| imsi informServiceCentre informServiceCentreArg |
	imsi := homeRoutingServer subscriberMap at: aMSISDN ifAbsent: [
		self logError: ('ID(<1p>) HomeRoutingDialogue no subscriber MSISDN(<2s>) '
						expandMacrosWith: self id with: aMSISDN) area: #home.
		anInvocation returnError: 'unknownSubscriber' with: nil.
		self requestTcEnd: false.
		^false].

	"We will need to remember information now."
	anInvocation returnResultLast: nil.

	"And say that we will remember it."
	(anInvocation argument sm_DeliveryOutcome value = 'successfulTransfer') ifTrue: [
		^self requestTcEnd: false].

	self logNotice: ('ID(<1p>) HomeRoutingDialogue adding to buffer MSISDN(<2s>) with SMSC(<3s>)'
						expandMacrosWith: self id with: aMSISDN with: anInvocation argument serviceCentreAddress fromE164)
						area: #home.
	homeRoutingServer registerSMSC: anInvocation argument serviceCentreAddress fromE164 for: anInvocation argument msisdn.

	informServiceCentreArg := ASN1Dictionary new
		at: 'storedMSISDN' put: aMSISDN toE164;
		at: 'mw-Status' put: '010000';
		yourself.
	informServiceCentre := self
		requestTcInvokeNamed: anOperationName parameters:  informServiceCentreArg
		class: 1 timeout: 500.
	self requestTcEnd: false.
	