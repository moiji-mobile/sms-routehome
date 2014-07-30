smpp
smppTimeout: aDialogue invocation: anInvocation
	"We didn't get a reply. So maybe it was scheduled. Maybe it wasn't."
	self logError: 'SMPP command timed-out'  area: #home.
	anInvocation returnError: 'sm-DeliveryFailure' with: nil.
	^aDialogue requestTcEnd: false.