as yet unclassified
testDelayedForwardSM
	| operationName dialogue  invoke invokeResultMessage param ended continued operation |

	ended := false.
	operationName := 'forwardSM'.
	dialogue := testEndPoint newDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onContinue: [continued := true];
		onEnd: [ended := true].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).

	self deny: ended.
	self assert: continued.

	operation := dialogue rosOperationNamed: operationName.
	param := operation argumentValue.
	(param expandFieldNamed: 'sm-RP-DA')
		imsi: '4321' toTBCD.
	(param expandFieldNamed: 'sm-RP-OA')
		serviceCentreAddressOA: (ByteArray readHexFrom: '912343').
	param sm_RP_UI:  (ByteArray readHexFrom: '040c9153345800485500004170716104000004d4f29c0e').

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: TCAPReportSuccessAndFailure  timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [:result | invokeResultMessage := result ].
	dialogue requestTcContinue.
	

	self assert: invokeResultMessage result isNil.
	self assert: ended.