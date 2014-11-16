as yet unclassified
smppReturnFailureOn: aHandler for: incomingMessage
	| response |
	incomingMessage body isCommand
		ifFalse: [^self error: 'Body should have been a command'].

	response := SMPPMessage new
					header: (SMPPPDUHeader new
						commandId: incomingMessage body responseForCommand;
						commandStatus: 8;
						sequenceNumber: incomingMessage header sequenceNumber;
						yourself);
					body: incomingMessage body responseErrorBody.
	aHandler sendDirect: response toMessage asByteArray.