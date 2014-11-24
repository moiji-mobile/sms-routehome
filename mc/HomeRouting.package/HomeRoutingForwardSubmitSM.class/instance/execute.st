as yet unclassified
execute
	| param |
	param := ASN1Dictionary new
		at: 'sm-RP-DA' put: (ASN1Dictionary new
			at: 'serviceCentreAddressDA' put: hlr mscNumber toE164;
			yourself);
		at: 'sm-RP-OA' put: (ASN1Dictionary new
			at: 'msisdn' put: subscriber msisdn toE164;
			yourself);
		at: 'sm-RP-UI' put: smRPUI;
		yourself.
		
	dialogue := dialogueHandler newDialogue.
	dialogue
		onPAbort: [self signalFailure];
		onUAbort: [self signalFailure].
		invoke := dialogue requestTcInvokeNamed: 'forwardSM' parameters:  param class: 1 timeout: 500.
	invoke
		onReturn: [self signalFailure];
		onError: [self signalFailure];
		onReject: [self signalFailure];
		onReturnLast: [:res | self signalSuccess: res].

	dialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddress
		originatingAddress: self localSCCPAddress
		applicationContextName: (dialogue applicationContextNamed: 'forwardSM').