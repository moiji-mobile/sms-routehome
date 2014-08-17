as yet unclassified
testSendRoutingInfoForSMV3Unreachable
	| operationName dialogue  invoke lastError sriArg |

	smppConnection setUnreachable.

	sriArg := ASN1Dictionary new
				at: 'msisdn' put: '1234' toE164;
				at: 'sm-RP-PRI' put: false;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

	operationName := 'sendRoutingInfoForSMV3'.
	dialogue := testEndPoint createDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false].

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
	

	self assert: lastError name equals: 'absentSubscriberSM'.