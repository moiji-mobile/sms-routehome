as yet unclassified
testIncomingSubmitSMNoSubscriber
	| submitSM response |
	submitSM := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream.
	smppConnection handler dispatchMessage: submitSM.

	"We expect that we received an error for the submitSM"
	self assert: smppConnection sent size equals: 1.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPSubmitSMResponse.
	self assert: response header sequenceNumber equals: submitSM header sequenceNumber.
	self assert: response header commandStatus equals: 8.