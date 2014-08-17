creation
initialize
	super initialize.
	sawInvocation := false.

	self onInvoke: [:invocation |
		self dispatchInvocation: invocation].