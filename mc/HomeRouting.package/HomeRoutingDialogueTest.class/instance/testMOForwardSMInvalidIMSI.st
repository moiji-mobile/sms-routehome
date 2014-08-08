as yet unclassified
testMOForwardSMInvalidIMSI
	| operationName dialogue  invoke lastError sriArg |

	sriArg := ASN1Dictionary new
				at: 'sm-RP-DA' put: (ASN1Dictionary new
					at: 'imsi' put: '43215' toTBCD;
					yourself);
				at: 'sm-RP-OA' put: (ASN1Dictionary new
					at: 'serviceCentreAddressOA' put: '912343';
					yourself);
				at: 'sm-RP-UI' put: '040c9153345800485500004170716104000004d4f29c0e';
				yourself.

	operationName := 'mo-ForwardSM'.
	dialogue := testEndPoint createDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
				class: TCAPReportSuccessAndFailure  timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [:err | lastError := err];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	

	self assert: lastError name equals: 'unexpectedDataValue'