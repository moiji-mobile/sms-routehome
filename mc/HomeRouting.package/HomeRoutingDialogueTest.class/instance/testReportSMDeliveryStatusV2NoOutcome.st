as yet unclassified
testReportSMDeliveryStatusV2NoOutcome
	| operationName dialogue  invoke sriArg returnLastSeen lastInvoke |

	smppConnection setUnreachable.

	sriArg := ASN1Dictionary new
				at: 'msisdn' put: '1234' toE164;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

	operationName := 'reportSM-DeliveryStatusV2'.
	dialogue := testEndPoint newDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onInvoke: [:msg | lastInvoke := msg].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
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