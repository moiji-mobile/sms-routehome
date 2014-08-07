smpp
continueOrEnd: aDialogue invocation: anInvocation
	anInvocation argument moreMessagesToSend isNil
		ifTrue: [aDialogue requestTcEnd: false]
		ifFalse: [aDialogue requestTcContinue].