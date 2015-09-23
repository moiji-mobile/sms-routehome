as yet unclassified
execute
	| param operation |

	dialogue := dialogueHandler newDialogue.
	operation := dialogue rosOperationNamed: self operationName.
	param := operation argumentValue.
	(param expandFieldNamed: 'sm-RP-DA')
		at: 'serviceCentreAddressDA' put: remoteGlobalTitle toE164.
	(param expandFieldNamed: 'sm-RP-OA')
		at: 'msisdn' put: msisdnAsE164.
	param at: 'sm-RP-UI' put: smRPUI.

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