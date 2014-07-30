dispatch
dispatchInvocation: anInvocation
	| selector |
	selector := anInvocation normalizedOperationName.

	"Abort the entire dialogue in case we don't know the invocation."
	(self respondsTo: selector)
		ifFalse: [
			self logError: 'HomeRoutingDialogue not handler for: ', selector asString area: #home.
			^self requestTcUAbort: TCAPDialogueUAbort serviceUser ].

	self perform: anInvocation normalizedOperationName with: anInvocation.