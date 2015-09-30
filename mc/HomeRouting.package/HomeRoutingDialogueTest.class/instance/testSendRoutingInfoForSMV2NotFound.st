as yet unclassified
testSendRoutingInfoForSMV2NotFound
	| operation operationName dialogue  invoke lastError sriArg |

	dialogue := testEndPoint newDialogue.
	operationName := 'sendRoutingInfoForSMV2'.
	operation := dialogue rosOperationNamed: operationName.
	
	sriArg := operation newArgumentValue
				at: 'msisdn' put: '912345' toE164;
				at: 'sm-RP-PRI' put: false;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

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

	"TODO.... check for unknownSubscriber... but so far we can only go for numbers"
	self assert: lastError name = 'unknownSubscriber'
	
