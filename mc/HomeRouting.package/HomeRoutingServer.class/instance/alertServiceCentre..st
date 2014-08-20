as yet unclassified
alertServiceCentre: anEntry
	| param dialogue invocation |
	param := ASN1Dictionary new
				at: 'msisdn' put: anEntry encodedMSISDN;
				at: 'serviceCentreAddress' put: anEntry smscAddress;
				yourself.
	dialogue := endPoint createDialogue.
	invocation := dialogue requestTcInvokeNamed: 'alertServiceCentre' parameters:  param class: 1 timeout: 500.
	dialogue
		requestTcBeginDestinationAddress: (self remoteSCCPAddress: anEntry smscAddress)
		originatingAddress: self localSCCPAddress
		applicationContextName: (dialogue tcapModel applicationContextOidForOperationNamed: 'alertServiceCentre').
	"Don't care aboute the result"