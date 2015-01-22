creation
applicationContextForOperationCode: aNumber
	"Some SMSCs from Sweden make a TC-BEGIN without an Application Context.
	Resolve the AC for them"

	self
		logDebug: ('ID(<1p>) Unknown applicationContextForOperation invoke(<2p>)' expandMacrosWith: self id with:  aNumber) 		area: #home.
	"Orange? likes to send forwardSM without ACN"
	aNumber = 46
		ifTrue: [^(self asn1TypeNamed: 'mo-ShortMsgRelayPackage-v2')].
	^super applicationContextForOperationCode: aNumber.