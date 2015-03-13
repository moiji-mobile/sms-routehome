as yet unclassified
testIncomingSubmitSMWithDeliveryReceipt
	| submitSM response mapReq deliverSM |

	"Check if we receive a forwardSM.."
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
				mapReq := tcapNotify invocation.
				tcapNotify returnResultLast: nil.
				diag requestTcEnd: false]].

	submitSM := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSMDeliveryReportMessageReference readStream.
	smppConnection handler dispatchMessage: submitSM.
	
	"Assert we received a mapRequest"
	self deny: mapReq isNil.
	self assert: mapReq operationName equals: 'forwardSM'.

	"We expect that we received an a result for the submitSM and a deliverySM"
	self assert: smppConnection sent size equals: 2.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPSubmitSMResponse.
	self assert: response header sequenceNumber equals: submitSM header sequenceNumber.
	self assert: response header commandStatus equals: 0.
	self assert: response body messageId equals: '0'.
	
	deliverSM := SMPPMessage readFrom: smppConnection sent second readStream.
	self assert: deliverSM body isCommand.
	self assert: deliverSM body class equals: SMPPDeliverSM.
	self assert: deliverSM body esmClass equals: 16r04.
	self assert: deliverSM body userMessageReference equals: #[0 9].