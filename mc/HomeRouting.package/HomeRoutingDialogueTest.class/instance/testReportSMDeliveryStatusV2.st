as yet unclassified
testReportSMDeliveryStatusV2
	| operationName dialogue  invoke param operation returned_last |

	smppConnection setUnreachable.
	
	dialogue := testEndPoint newDialogue.
	operationName := 'reportSM-DeliveryStatusV2'.
	operation := dialogue rosOperationNamed: operationName.
	
	param := operation newArgumentValue
				at: 'msisdn' put: '1234' toE164;
				at: 'serviceCentreAddress' put: '912343' toE164;
				at: 'sm-DeliveryOutcome' put: 'memoryCapacityExceeded';
				yourself.

	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
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