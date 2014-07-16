as yet unclassified
testSendRoutingInfoForSMV2NotFound
	| operationName dialogue  invoke lastError sriArg |
	
	sriArg := ASN1Dictionary new
				at: 'msisdn' put: '12345' toE164;
				at: 'sm-RP-PRI' put: false;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

	operationName := 'sendRoutingInfoForSMV2'.
	dialogue := testEndPoint createDialogue.
	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
				class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [:err | lastError := err];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).

	"TODO.... check for unknownSubscriber... but so far we can only go for numbers"
	self assert: lastError errorCode equals: 1
	
