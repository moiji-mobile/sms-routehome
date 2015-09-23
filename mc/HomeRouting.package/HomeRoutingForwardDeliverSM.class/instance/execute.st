as yet unclassified
execute
	| operationName operation param invoke |

	dialogue := dialogueHandler newDialogue.
	operationName := 'sendRoutingInfoForSMV2'.
	operation := dialogue rosOperationNamed: operationName.
	param := operation argumentValue
			at: 'msisdn' put: msisdnE164;
			at: 'sm-RP-PRI' put: true;
			at: 'serviceCentreAddress' put: hlrAddress toE164;
			yourself.

	dialogue
		onPAbort: [self signalFailure];
		onUAbort: [self signalFailure].
	invoke := dialogue
				requestTcInvokeNamed: operationName parameters:  param
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
		applicationContextName: (dialogue applicationContextOidForOperationNamed: operationName).