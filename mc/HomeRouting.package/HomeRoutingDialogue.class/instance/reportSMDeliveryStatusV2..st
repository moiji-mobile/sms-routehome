shortMsgGatewayPackage
reportSMDeliveryStatusV2: anInvocation
	| msisdn smscAddr |
	msisdn := anInvocation argument msisdn fromE164.
	smscAddr := anInvocation argument serviceCentreAddress fromE164.

	self handleSMDeliveryStatus: msisdn invocation: anInvocation operation: 'informServiceCentreV2'.
