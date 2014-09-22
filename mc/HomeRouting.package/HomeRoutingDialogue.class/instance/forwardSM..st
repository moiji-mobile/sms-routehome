shortMsgRelayPackage
forwardSM: anInvocation
	"TODO. Extract IMSI and use execute.."
	HomeroutingForwardSM new
		hlr: hlr;
		dialogue: self;
		invocation: anInvocation;
		forwardSM.