smpp
smppError

	"Okay, it failed somehow. We will have to see why in the future"
	self logError: ('ID(<1p>) SMPP command failed'
					expandMacrosWith: dialogue id) area: #home.
	invocation returnError: 'sm-DeliveryFailure' with: nil.
	self continueOrEnd.