dispatch
indicationTrBegin: aMessage
	super indicationTrBegin: aMessage.
	"TODO: Start a timer for clean-up?"
	self flag: #todo.
	sawInvocation ifFalse: [
		"Accept the dialogue and continue..."
		self requestTcContinue].