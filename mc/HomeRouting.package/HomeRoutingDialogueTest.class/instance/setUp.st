as yet unclassified
setUp
	| testHomeRouting hlrEndPoint |
	testHomeRouting := HomeRoutingServer new
			hlrNumber: '35412';
			mscNumber: '35411';
			subscriberMap: (Dictionary new at: '1234' put: '4321'; yourself);
			smppConnection: SMPPMockConnection new;
			yourself.

	testEndPoint := TCAPTestServiceEndPoint new.
	hlrEndPoint := TCAPTestServiceEndPoint newHomeRouting.
	hlrEndPoint transactionCoordinator: TCAPTestTransactionCoordinator new.
	hlrEndPoint factory homeRoutingServer: testHomeRouting.
	testHomeRouting endPoint: hlrEndPoint.

	testEndPoint connectTo: hlrEndPoint.
	hlrEndPoint connectTo: testEndPoint.