as yet unclassified
setUp
	| hlrEndPoint |
	smppConnection := SMPPMockConnection new.
	testHomeRouting := HomeRoutingServer new
			hlrNumber: '35412';
			mscNumber: '35411';
			smppConnection: smppConnection;
			yourself.
	testHomeRouting database
		insert: (HomeRoutingSubscriber new
					msisdn: '1234';
					imsi: '4321';
					yourself).

	testHomeRouting addMOSMSRule:
		(HomeRoutingMOSMSMSISDNConfig new
			sourceMsisdnMatch: '[0-9]*' asRegex;
			destinationMsisdnMatch: '[0-9]*' asRegex;
			smscNumber: '91143';
			useForwardSM;
			validityPeriod: 7 days;
			yourself).
	testHomeRouting addMTSMSRule:
		(HomeRoutingMTSMSMSISDNConfig new
			sourceMsisdnMatch: '[0-9]*' asRegex;
			destinationMsisdnMatch: '[0-9]*' asRegex;
			sendRoutingInfoTranslationType: 2;
			forwardSMTranslationType: 2;
			yourself).

	testEndPoint := TCAPTestServiceEndPoint new
		asn1Model: self asn1Model.
	hlrEndPoint := TCAPTestServiceEndPoint newHomeRouting
		asn1Model: self asn1Model.
	hlrEndPoint transactionCoordinator: TCAPTestTransactionCoordinator new.
	hlrEndPoint factory homeRoutingServer: testHomeRouting.
	testHomeRouting endPoint: hlrEndPoint.

	testEndPoint connectTo: hlrEndPoint.
	hlrEndPoint connectTo: testEndPoint.