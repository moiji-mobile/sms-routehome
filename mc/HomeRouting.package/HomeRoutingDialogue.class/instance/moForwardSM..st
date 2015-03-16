shortMsgRelayPackage
moForwardSM: anInvocation
	self
		logDebug: ('ID(<1p>) moForwardSM' expandMacrosWith: self id) area: #home.
	HomeroutingForwardSM new
		hlr: hlr;
		dialogue: self;
		invocation: anInvocation;
		forwardSM.