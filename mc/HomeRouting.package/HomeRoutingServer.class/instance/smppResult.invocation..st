smpp
smppResult: aDialogue invocation: anInvocation

	"We have received a positive report"
	self logNotice: ('ID(<1s>) SMPP command succeeded'
					expandMacrosWith: aDialogue id) area: #home.
	anInvocation returnResultLast: nil.
	aDialogue requestTcEnd: false.