as yet unclassified
initialize
	super initialize.
	moSmsConfigRules := OrderedCollection new.
	mtSmsConfigRules := OrderedCollection new.
	database := HomeRoutingSubscriberDatabase new
					homeRoutingServer: self;
					yourself.