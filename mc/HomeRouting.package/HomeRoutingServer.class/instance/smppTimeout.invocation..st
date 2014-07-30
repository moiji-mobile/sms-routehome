smpp
smppTimeout: aDialogue invocation: anInvocation
	"We didn't get a reply. So maybe it was scheduled. Maybe it wasn't."
	self logError: ('ID(<1s>) SMPP command timed-out'
					expandMacrosWith: aDialogue id) area: #home.
	anInvocation returnError: 'sm-DeliveryFailure' with: nil.
	^aDialogue requestTcEnd: false.