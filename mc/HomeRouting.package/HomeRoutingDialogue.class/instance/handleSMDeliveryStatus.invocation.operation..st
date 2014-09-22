as yet unclassified
handleSMDeliveryStatus: aMSISDN invocation: anInvocation operation: anOperationName
	| aSubscriber |
	aSubscriber := homeRoutingServer database findMSISDN: aMSISDN.
	aSubscriber ifNil: [
		self logError: ('ID(<1p>) HomeRoutingDialogue no subscriber MSISDN(<2s>) '
						expandMacrosWith: self id with: aMSISDN) area: #home.
		anInvocation returnError: 'unknownSubscriber' with: nil.
		self requestTcEnd: false.
		^false].

	"We will need to remember information now."
	anInvocation returnResultLast: nil.
	self requestTcEnd: false.
	