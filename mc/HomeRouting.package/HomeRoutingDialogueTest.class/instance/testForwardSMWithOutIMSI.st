as yet unclassified
testForwardSMWithOutIMSI
	| operationName dialogue  invoke operation param errored ended |

	operationName := 'forwardSM'.
	dialogue := testEndPoint newDialogue.

	operation := dialogue rosOperationNamed: operationName.
	param := operation newArgumentValue.
	(param expandFieldNamed: 'sm-RP-DA')
		serviceCentreAddressDA: '4321' toE164.
	(param expandFieldNamed: 'sm-RP-OA')
		serviceCentreAddressOA: (ByteArray readHexFrom: '912343').
	param sm_RP_UI:  (ByteArray readHexFrom: '040c9153345800485500004170716104000004d4f29c0e').


	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onContinue: [self assert: false ];
		onEnd: [ended := true].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: TCAPReportSuccessAndFailure  timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [errored := true];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	

	self assert: ended.
	self assert: errored.