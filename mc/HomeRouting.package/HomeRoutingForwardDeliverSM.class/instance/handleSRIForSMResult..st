as yet unclassified
handleSRIForSMResult: aResult
	| imsi mscNumber operationName operation param invoke |
	imsi := aResult resultObject imsi.
	mscNumber := aResult resultObject locationInfoWithLMSI networkNode_Number fromE164.

	dialogue := dialogueHandler newDialogue.
	operationName := 'forwardSM'.
	operation := dialogue rosOperationNamed: operationName.

	param := operation argumentValue.
	(param expandFieldNamed: 'sm-RP-DA')
			at: 'imsi' put: imsi.
	(param expandFieldNamed: 'sm-RP-OA') 
			at: 'serviceCentreAddressOA' put: hlr mscNumber toE164.
	param at: 'sm-RP-UI' put: smRPUI.

	dialogue
		onPAbort: [self signalFailure];
		onUAbort: [self signalFailure].
	invoke := dialogue requestTcInvokeNamed: operationName parameters:  param class: 1 timeout: 60.
	invoke
		onReturn: [self signalFailure];
		onError: [self signalFailure];
		onReject: [self signalFailure];
		onLCancel: [self signalFailure];
		onReturnLast: [:res | self signalSuccess: res].

	dialogue
		requestTcBeginDestinationAddress: (self remoteSCCPAddressForForward: mscNumber)
		originatingAddress: self localSCCPAddress
		applicationContextName: (dialogue applicationContextOidForOperationNamed: 'forwardSM').