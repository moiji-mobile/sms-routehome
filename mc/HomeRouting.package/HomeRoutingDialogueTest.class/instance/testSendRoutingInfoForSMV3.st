as yet unclassified
testSendRoutingInfoForSMV3
	| operation operationName dialogue  invoke invokeResultMessage sriArg |

	dialogue := testEndPoint newDialogue.
	operationName := 'sendRoutingInfoForSMV3'.
	operation := dialogue rosOperationNamed: operationName.
	
	sriArg := operation newArgumentValue
				at: 'msisdn' put: '1234' toE164;
				at: 'sm-RP-PRI' put: false;
				at: 'serviceCentreAddress' put: '912343' toE164;
				yourself.

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
		onReturnLast: [:result | invokeResultMessage := result ].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	

	self assert: invokeResultMessage resultObject imsi = '4334' toTBCD.