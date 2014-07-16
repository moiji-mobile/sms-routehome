as yet unclassified
setUp
	| testHlr hlrEndPoint |
	testHlr := HomeRoutingServer new
			hlrNumber: '35412';
			subscriberMap: (Dictionary new at: '1234' put: '4321'; yourself);
			yourself.

	testEndPoint := TCAPTestServiceEndPoint new.
	hlrEndPoint := TCAPTestServiceEndPoint newHomeRouting.
	hlrEndPoint transactionCoordinator: TCAPTestTransactionCoordinator new.
	hlrEndPoint factory hlr: testHlr.
	testHlr endPoint: hlrEndPoint.

	testEndPoint connectTo: hlrEndPoint.
	hlrEndPoint connectTo: testEndPoint.