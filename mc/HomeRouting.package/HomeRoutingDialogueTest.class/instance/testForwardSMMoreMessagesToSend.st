as yet unclassified
testForwardSMMoreMessagesToSend
	| operationName dialogue  invoke invokeResultMessage sriArg continued  |

	sriArg := ASN1Dictionary new
				at: 'sm-RP-DA' put: (ASN1Dictionary new
					at: 'imsi' put: '4321' toTBCD;
					yourself);
				at: 'sm-RP-OA' put: (ASN1Dictionary new
					at: 'serviceCentreAddressOA' put: '912343';
					yourself);
				at: 'sm-RP-UI' put: '040c9153345800485500004170716104000004d4f29c0e';
				at: 'moreMessagesToSend' put: 1;
				yourself.

	operationName := 'forwardSM'.
	dialogue := testEndPoint createDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onContinue: [continued := true];
		onEnd: [self assert: false].

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
	

	self assert: invokeResultMessage result isNil.
	self assert: continued.