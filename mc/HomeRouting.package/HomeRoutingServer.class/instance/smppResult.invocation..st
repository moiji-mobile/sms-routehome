smpp
smppResult: aDialogue invocation: anInvocation

	"We have received a positive report"
	self logNotice: 'SMPP command succeeded'  area: #home.
	anInvocation returnResultLast: nil.
	aDialogue requestTcEnd: false.