as yet unclassified
testSendRoutingInfoForSMV2Unrechable
	| operation operationName dialogue  invoke lastResult sriArg |

	smppConnection setUnreachable.

	dialogue := testEndPoint newDialogue.
	operationName := 'sendRoutingInfoForSMV2'.
	operation := dialogue rosOperationNamed: operationName.
	
	sriArg := operation newArgumentValue
				at: 'msisdn' put: '1234' toE164;
				at: 'sm-RP-PRI' put: false;
				at: 'serviceCentreAddress' put: '912343' toE164;
				yourself.

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
