as yet unclassified
testMOForwardSMRejected
	| operationName dialogue operation param invoke wasAborted |

	dialogue := testEndPoint newDialogue.
	operationName := 'mo-ForwardSM'.	
	operation := dialogue rosOperationNamed: operationName.
	param := operation argumentValue.
	(param expandFieldNamed: 'sm-RP-DA')
		at: 'imsi' put: '4321' toTBCD.
	(param expandFieldNamed: 'sm-RP-OA')
		at: 'serviceCentreAddressOA' put: (ByteArray readHexFrom: '912343').
	param at: 'sm-RP-UI' put: (ByteArray readHexFrom: '040c9153345800485500004170716104000004d4f29c0e').

	wasAborted := true.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | wasAborted := true].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: TCAPReportSuccessAndFailure  timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	

	self assert: wasAborted