as yet unclassified
execute
	| sriArg operationName invoke |
	
	sriArg := ASN1Dictionary new
				at: 'msisdn' put: msisdnE164;
				at: 'sm-RP-PRI' put: true;
				at: 'serviceCentreAddress' put: hlrAddress toE164;
				yourself.

	operationName := 'sendRoutingInfoForSMV2'.
	dialogue := dialogueHandler newDialogue.
	dialogue
		onPAbort: [self signalFailure];
		onUAbort: [self signalFailure].
	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  sriArg
				class: 1 timeout: 60.
	invoke
		onReturn: [self signalFailure];
		onError: [self signalFailure];
		onReject: [self signalFailure];
		onLCancel: [self signalFailure];
		onReturnLast: [:result | self handleSRIForSMResult: result].
	dialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForSRIForSM
		originatingAddress: self localSCCPAddress
		applicationContextName: (dialogue applicationContextNamed: operationName).