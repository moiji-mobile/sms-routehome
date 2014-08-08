dispatch
dispatchInvocation: anInvocation
	| selector |
	selector := anInvocation normalizedOperationName.

	"Abort the entire dialogue in case we don't know the invocation."
	(self respondsTo: selector)
		ifFalse: [
			
			self logError: ('ID(<1p>) HomeRoutingDialogue not handler for: <2s>' expandMacrosWith: self id with:  selector) area: #home.
			^self requestTcUAbort: TCAPDialogueUAbort serviceUser ].

	self perform: anInvocation normalizedOperationName with: anInvocation.