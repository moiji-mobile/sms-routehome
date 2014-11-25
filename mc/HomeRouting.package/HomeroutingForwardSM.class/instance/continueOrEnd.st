as yet unclassified
continueOrEnd
	(invocation argument hasField: 'moreMessagesToSend')
		ifFalse: [^dialogue requestTcEnd: false].
	invocation argument moreMessagesToSend isNil
		ifTrue: [^dialogue requestTcEnd: false].

	^dialogue requestTcContinue