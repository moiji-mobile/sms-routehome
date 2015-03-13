as yet unclassified
setUp
	| homeRoutingServer |
	homeRoutingServer := HomeRoutingServer new.
	database := homeRoutingServer database.
	database addPair: (HomeRoutingPrefixPair new
					imsiPrefix: '456';
					msisdnPrefix: '1235';
					yourself).