as yet unclassified
testMTForwardSMNoConnection
	| operationName dialogue  invoke invokeErrorMessage operation param |

	smppConnection setUnreachable.

	dialogue := testEndPoint newDialogue.
	operationName := 'mt-ForwardSM'.
	operation := dialogue rosOperationNamed: operationName.
	param := operation newArgumentValue.
	(param expandFieldNamed: 'sm-RP-DA')
		at: 'imsi' put: '4321' toTBCD.
	(param expandFieldNamed: 'sm-RP-OA')
		at: 'serviceCentreAddressOA' put: (ByteArray readHexFrom: '912343').
	param at: 'sm-RP-UI' put: (ByteArray readHexFrom: '040c9153345800485500004170716104000004d4f29c0e').

	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: TCAPReportSuccessAndFailure  timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [:result | invokeErrorMessage := result];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	

	self deny: invokeErrorMessage isNil.
	self assert: smppConnection scheduledCommands size equals: 0.