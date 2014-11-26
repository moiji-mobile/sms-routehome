as yet unclassified
testForwardSMWithOutIMSI
	| operationName dialogue  invoke  sriArg errored ended |

	sriArg := ASN1Dictionary new
				at: 'sm-RP-DA' put: (ASN1Dictionary new
					at: 'serviceCentreAddressDA' put: '4321' toE164;
					yourself);
				at: 'sm-RP-OA' put: (ASN1Dictionary new
					at: 'serviceCentreAddressOA' put: (ByteArray readHexFrom: '912343');
					yourself);
				at: 'sm-RP-UI' put: (ByteArray readHexFrom: '040c9153345800485500004170716104000004d4f29c0e');
				yourself.

	operationName := 'forwardSM'.
	dialogue := testEndPoint newDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onContinue: [self assert: false ];
		onEnd: [ended := true].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
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