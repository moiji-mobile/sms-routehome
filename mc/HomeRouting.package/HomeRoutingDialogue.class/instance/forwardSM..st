shortMsgRelayPackage
forwardSM: anInvocation
	"TODO. Extract IMSI and use execute.."
	self
		logDebug: ('ID(<1p>) forwardSM' expandMacrosWith: self id) area: #home.
	HomeroutingForwardSM new
		hlr: hlr;
		dialogue: self;
		invocation: anInvocation;
		forwardSM.