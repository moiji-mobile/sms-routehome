smpp
smppReturnSuccessOn: aHandler for: incomingMessage with: aResult
	| response |
	response := SMPPMessage new
					header: (SMPPPDUHeader new
						commandId: incomingMessage body responseForCommand;
						commandStatus: 0;
						sequenceNumber: incomingMessage header sequenceNumber;
						yourself);
					body: (SMPPSubmitSMResponse new messageId: '0'; yourself).
	aHandler sendDirect: response toMessage asByteArray.