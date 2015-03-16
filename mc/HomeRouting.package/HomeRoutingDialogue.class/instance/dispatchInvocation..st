dispatch
dispatchInvocation: anInvocation
	| selector |
	selector := anInvocation normalizedOperationName.
	self
		logDebug: ('ID(<1p>) dispatchInvocation invoke(<2p>)' expandMacrosWith: self id with:  selector) area: #home.

	"The HLR may handle this. This means the normalizedOperatorName
	will be created twice right now."
	(#(#reportSMDeliveryStatusV2: #reportSMDeliveryStatusV3:
	     #sendRoutingInfoForSMV2: sendRoutingInfoForSMV3:) includes: selector) ifTrue: [
		^super dispatchInvocation: anInvocation
	].

	"Abort the entire dialogue in case we don't know the invocation."
	(self class includesLocalSelector: selector)
		ifFalse: [
			
			self logError: ('ID(<1p>) HomeRoutingDialogue not handler for: <2s>' expandMacrosWith: self id with:  selector) area: #home.
			^self requestTcUAbort: self newUAbort serviceUser ].

	self perform: anInvocation normalizedOperationName with: anInvocation.