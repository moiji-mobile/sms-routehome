as yet unclassified
handleSRIForSMResult: aResult
	| imsi mscNumber param invoke |
	imsi := aResult decodedResult imsi.
	mscNumber := aResult decodedResult locationInfoWithLMSI networkNode_Number fromE164.


	param := ASN1Dictionary new
		at: 'sm-RP-DA' put: (ASN1Dictionary new
			at: 'imsi' put: imsi;
			yourself);
		at: 'sm-RP-OA' put: (ASN1Dictionary new
			at: 'serviceCentreAddressOA' put: hlr mscNumber toE164;
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
		requestTcBeginDestinationAddress: (self remoteSCCPAddressForForward: mscNumber)
		originatingAddress: self localSCCPAddress
		applicationContextName: (dialogue applicationContextNamed: 'forwardSM').