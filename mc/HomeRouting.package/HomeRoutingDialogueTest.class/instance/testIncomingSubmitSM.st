as yet unclassified
testIncomingSubmitSM
	| submitSM response mapReq extracted  |

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
	self assert: mapReq argument sm_RP_DA serviceCentreAddressDA fromE164 equals: '91143'.

	extracted := HomeRoutingTPDUHelper extractSubmitFrom: mapReq argument sm_RP_UI readStream.
	self assert: (extracted at: 'TP-VPFI') equals: 2r10.
	self assert: (extracted at: 'TP-VP') equals: #[173].

	"We expect that we received an error for the submitSM"
	self assert: smppConnection sent size equals: 1.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPSubmitSMResponse.
	self assert: response header sequenceNumber equals: submitSM header sequenceNumber.
	self assert: response header commandStatus equals: 0.
	self assert: response body messageId equals: '0'.