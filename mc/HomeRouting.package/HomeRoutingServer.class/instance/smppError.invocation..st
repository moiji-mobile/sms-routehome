smpp
smppError: aDialogue invocation: anInvocation

	"Okay, it failed somehow. We will have to see why in the future"
	anInvocation returnError: 'sm-DeliveryFailure' with: nil.
	aDialogue requestTcEnd: false.