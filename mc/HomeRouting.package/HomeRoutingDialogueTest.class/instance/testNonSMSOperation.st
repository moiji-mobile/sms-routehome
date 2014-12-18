as yet unclassified
testNonSMSOperation
	| operationName dialogue  invoke abort sriArg |

	sriArg := #[1 2 3 4].
	operationName := 'sendIdentificationV2'.
	dialogue := testEndPoint newDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:info | abort := info].

	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
				class: 1 timeout: 500.
	invoke
		onReturn: [self assert: false ];
		onError: [self assert: false];
		onReject: [self assert: false];
		onReturnLast: [self assert: false].
	dialogue
		requestTcBeginDestinationAddress: self hlrAddr
		originatingAddress: self localAddr
		applicationContextName: (self applicationContextFor: operationName).
	

	self deny: abort isNil.
	self assert: abort message reason u_abortCause dialogueAbort abort_source equals: 0.