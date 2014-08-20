as yet unclassified
testReportSMDeliveryStatusV3NoOutcome
	| operationName dialogue  invoke sriArg returnLastSeen lastInvoke lastDialogue |

	smppConnection setUnreachable.

	sriArg := ASN1Dictionary new
				at: 'msisdn' put: '1234' toE164;
				at: 'serviceCentreAddress' put: '912343';
				yourself.

	operationName := 'reportSM-DeliveryStatusV3'.
	dialogue := testEndPoint createDialogue.
	dialogue
		onPAbort: [:msg | self assert: false];
		onUAbort: [:msg | self assert: false];
		onInvoke: [:msg | lastInvoke := msg].

	self assert: testHomeRouting pendingAlerts size equals: 0.
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
	self deny: lastInvoke isNil.
	self assert: lastInvoke operationName equals: 'informServiceCentreV3'.
	self assert: testHomeRouting pendingAlerts size equals: 1.

	"Now see if we get an invocation"
	lastInvoke := nil.
	testEndPoint onDialogue: [:diag | lastDialogue := diag. diag onInvoke: [:new_invocation | lastInvoke := new_invocation]].
	testHomeRouting alertServiceCentres.
	testHomeRouting pendingAlerts first expirationTime: (DateAndTime now - 1 minute).
	testHomeRouting alertServiceCentres.
	self assert: testHomeRouting pendingAlerts size equals: 0.
	self deny: lastDialogue isNil.
	self deny: lastInvoke isNil.
	self assert: lastInvoke operationName equals: 'alertServiceCentre'.
	"TODO.. check more.."