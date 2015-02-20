as yet unclassified
execute
	| param |
	param := ASN1Dictionary new
		at: 'sm-RP-DA' put: (ASN1Dictionary new
			at: 'serviceCentreAddressDA' put: remoteGlobalTitle toE164;
			yourself);
		at: 'sm-RP-OA' put: (ASN1Dictionary new
			at: 'msisdn' put: msisdnAsE164;
			yourself);
		at: 'sm-RP-UI' put: smRPUI;
		yourself.
		
	dialogue := dialogueHandler newDialogue.
	dialogue
		onPAbort: [self signalFailure];
		onUAbort: [self signalFailure].
		invoke := dialogue requestTcInvokeNamed: self operationName parameters:  param class: 1 timeout: 60.
	invoke
		onReturn: [self signalFailure];
		onError: [self signalFailure];
		onReject: [self signalFailure];
		onLCancel: [self signalFailure];
		onReturnLast: [:res | self signalSuccess: res].
	dialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddress
		originatingAddress: self localSCCPAddress
		applicationContextName: self applicationContexOID.