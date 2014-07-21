smpp
smppResult: aDialogue invocation: anInvocation

	"We have received a positive report"
	anInvocation returnResultLast: nil.
	aDialogue requestTcEnd: false.