smpp
smppError: aDialogue invocation: anInvocation

	"Okay, it failed somehow. We will have to see why in the future"
	self logError: ('ID(<1s>) SMPP command failed'
					expandMacrosWith: aDialogue id) area: #home.
	anInvocation returnError: 'sm-DeliveryFailure' with: nil.
	self continueOrEnd: aDialogue invocation: anInvocation.