as yet unclassified
continueOrEnd
	invocation argument moreMessagesToSend isNil
		ifTrue: [dialogue requestTcEnd: false]
		ifFalse: [dialogue requestTcContinue].