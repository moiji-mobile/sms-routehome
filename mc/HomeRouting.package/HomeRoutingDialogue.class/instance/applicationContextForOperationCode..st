creation
applicationContextForOperationCode: aNumber
	"Some SMSCs from Sweden make a TC-BEGIN without an Application Context.
	Resolve the AC for them"

	aNumber = 45
		ifTrue: [^(self tcapModel bindingNamed: 'shortMsgGatewayContext-v2') value].
	"Orange? likes to send forwardSM without ACN"
	aNumber = 46
		ifTrue: [^(self tcapModel bindingNamed: 'mo-ShortMsgRelayPackage-v2') value].
	^super applicationContextForOperationCode: aNumber.