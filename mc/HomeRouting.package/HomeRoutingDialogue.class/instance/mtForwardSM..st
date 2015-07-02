shortMsgRelayPackage
mtForwardSM: anInvocation
	self
		logDebug: ('ID(<1p>) mtForwardSM' expandMacrosWith: self id) area: #home.
	HomeroutingForwardSMv3 new
		hlr: hlr;
		dialogue: self;
		invocation: anInvocation;
		forwardSM.