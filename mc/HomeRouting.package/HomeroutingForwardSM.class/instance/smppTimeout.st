smpp
smppTimeout
	"We didn't get a reply. So maybe it was scheduled. Maybe it wasn't."
	self logError: ('ID(<1p>) SMPP command timed-out'
					expandMacrosWith: dialogue id) area: #home.
	self returnError.
	^self continueOrEnd.