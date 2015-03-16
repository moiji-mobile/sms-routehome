smpp
smppReturnSuccessOn: aHandler for: incomingMessage with: aResult
	| response |
	self
		logNotice: ('Server(<1p>) returning success to systemId(<2p>)' expandMacrosWith: mscNumber with: aHandler systemId) area: #home.
	response := SMPPMessage new
					header: (SMPPPDUHeader new
						commandId: incomingMessage body responseForCommand;
						commandStatus: 0;
						sequenceNumber: incomingMessage header sequenceNumber;
						yourself);
					body: incomingMessage body responseSuccessBody.
	aHandler sendDirect: response toMessage asByteArray.
