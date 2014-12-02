as yet unclassified
testIncomingSubmitSM
	| submitSM response mapReq |

	"Check if we receive a forwardSM.."
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
				mapReq := tcapNotify invocation.
				tcapNotify returnResultLast: nil.
				diag requestTcEnd: false]].

	submitSM := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream.
	smppConnection handler dispatchMessage: submitSM.
	
	"Assert we received a mapRequest"
	self deny: mapReq isNil.
	self assert: mapReq operationName equals: 'forwardSM'.

	"We expect that we received an error for the submitSM"
	self assert: smppConnection sent size equals: 1.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPSubmitSMResponse.
	self assert: response header sequenceNumber equals: submitSM header sequenceNumber.
	self assert: response header commandStatus equals: 0.
	self assert: response body messageId equals: '0'.