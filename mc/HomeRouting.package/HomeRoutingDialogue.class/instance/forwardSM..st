shortMsgRelayPackage
forwardSM: anInvocation
	| originatingAddress destinationAddress payload |
	
	originatingAddress := anInvocation argument sm_RP_OA.
	destinationAddress := anInvocation argument sm_RP_DA.
	payload := anInvocation argument sm_RP_UI asByteArray.

	homeRoutingServer forwardSM: self invocation: anInvocation