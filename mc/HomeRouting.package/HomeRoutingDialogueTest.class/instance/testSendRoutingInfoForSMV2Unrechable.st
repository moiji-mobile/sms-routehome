as yet unclassified
testSendRoutingInfoForSMV2Unrechable
	| operationName dialogue  invoke lastResult sriArg |

	smppConnection setUnreachable.
	
	sriArg := ASN1Dictionary new
				at: 'msisdn' put: '1234' toE164;
				at: 'sm-RP-PRI' put: false;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

	operationName := 'sendRoutingInfoForSMV2'.
	dialogue := testEndPoint newDialogue.
	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
				class: TCAPReportSuccessAndFailure  timeout: 500.
	dialogue
		onInvoke: [:inv | inv halt  ].
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [:res | lastResult := res].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).

	self deny: lastResult isNil.
	self assert: lastResult resultObject imsi fromTBCD equals: '4334'.
