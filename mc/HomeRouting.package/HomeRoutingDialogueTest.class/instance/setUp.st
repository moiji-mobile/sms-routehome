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
		insert: (Subscriber new
					msisdn: '1234';
					imsi: '4321';
					yourself).

	testEndPoint := TCAPTestServiceEndPoint new.
	hlrEndPoint := TCAPTestServiceEndPoint newHomeRouting.
	hlrEndPoint transactionCoordinator: TCAPTestTransactionCoordinator new.
	hlrEndPoint factory homeRoutingServer: testHomeRouting.
	testHomeRouting endPoint: hlrEndPoint.

	testEndPoint connectTo: hlrEndPoint.
	hlrEndPoint connectTo: testEndPoint.