as yet unclassified
setUp
	| homeRoutingServer |
	homeRoutingServer := HomeRoutingServer new.
	database := homeRoutingServer database.
	database imsiPrefix: '456'.
	database msisdnPrefix: '1235'.