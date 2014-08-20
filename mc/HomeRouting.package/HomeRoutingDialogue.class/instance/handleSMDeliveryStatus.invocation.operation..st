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

	informServiceCentreArg := ASN1Dictionary new
		at: 'storedMSISDN' put: aMSISDN toE164;
		at: 'mw-Status' put: '010000';
		yourself.
	informServiceCentre := self
		requestTcInvokeNamed: anOperationName parameters:  informServiceCentreArg
		class: 1 timeout: 500.
	self requestTcEnd: false.
	