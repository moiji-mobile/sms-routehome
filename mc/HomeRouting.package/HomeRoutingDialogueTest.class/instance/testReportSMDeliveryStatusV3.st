as yet unclassified
testReportSMDeliveryStatusV3
	| operationName dialogue  invoke sriArg returned_last |

	smppConnection setUnreachable.

	sriArg := ASN1Dictionary new
				at: 'msisdn' put: '1234' toE164;
				at: 'serviceCentreAddress' put: '912343';
				at: 'sm-DeliveryOutcome' put: 'memoryCapacityExceeded';
				yourself.

	operationName := 'reportSM-DeliveryStatusV3'.
	dialogue := testEndPoint createDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
				class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [returned_last := true].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	
	self assert: returned_last.