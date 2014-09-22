smpp
smppResult

	"We have received a positive report"
	self logNotice: ('ID(<1p>) SMPP command succeeded'
					expandMacrosWith: dialogue id) area: #home.
	invocation returnResultLast: nil.
	self continueOrEnd