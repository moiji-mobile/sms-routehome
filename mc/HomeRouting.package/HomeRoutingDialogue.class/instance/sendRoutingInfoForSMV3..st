shortMsgGatewayPackage
sendRoutingInfoForSMV3: anInvocation
	<consumer: 'GMSC'>
	<package: 'shortMsgGatewayPackage-v3'>

	| msisdn smscAddr  |
	msisdn := anInvocation argument msisdn fromE164.
	smscAddr := anInvocation argument serviceCentreAddress fromE164.

	self handleSRiForSM: msisdn smscAddr: smscAddr invocation: anInvocation