as yet unclassified
testReportSMDeliveryStatusV2NoOutcome
	| operation operationName dialogue  invoke param returnLastSeen lastInvoke |

	smppConnection setUnreachable.

	dialogue := testEndPoint newDialogue.
	operationName := 'reportSM-DeliveryStatusV2'.
	operation := dialogue rosOperationNamed: operationName.
	
	param := operation newArgumentValue
				at: 'msisdn' put: '1234' toE164;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onInvoke: [:msg | lastInvoke := msg].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [returnLastSeen := true].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	
	self assert: returnLastSeen.
	self assert: lastInvoke isNil.