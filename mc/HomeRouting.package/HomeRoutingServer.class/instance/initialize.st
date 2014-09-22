as yet unclassified
initialize
	super initialize.
	database := HomeRoutingSubscriberDatabase new
					homeRoutingServer: self;
					yourself.