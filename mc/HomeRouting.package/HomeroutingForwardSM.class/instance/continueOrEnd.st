as yet unclassified
continueOrEnd
	(invocation argument hasField: 'moreMessagesToSend') 
		ifTrue: [dialogue requestTcContinue]
		ifFalse: [dialogue requestTcEnd: false]
