as yet unclassified
testIncomingDeliverSM
	| deliverSM response mapReqSRI |

	"Check if we receive a forwardSM.."
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
				| isSRIForSM isFwdSM |
				isSRIForSM := tcapNotify invocation operationName = 'sendRoutingInfoForSMV2'.
				isFwdSM := tcapNotify invocation operationName = 'forwardSM'.
				isSRIForSM ifTrue: [
					mapReqSRI := tcapNotify invocation.
					tcapNotify returnResultLast: (ASN1Dictionary new
							at: 'imsi' put: '1234' toTBCD;
							at: 'locationInfoWithLMSI' put: (ASN1Dictionary new
								at: 'networkNode-Number' put: '4321' toE164;
								yourself);
							yourself).
					diag requestTcEnd: false].
				isFwdSM ifTrue: [
					tcapNotify returnResultLast: nil.
					diag requestTcEnd: false]]].

	deliverSM := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	smppConnection handler dispatchMessage: deliverSM.
	
	"Assert we received a mapRequest"
	self deny: mapReqSRI isNil.
	self assert: mapReqSRI operationName equals: 'sendRoutingInfoForSMV2'.

	"We expect that we received an error for the submitSM"
	self assert: smppConnection sent size equals: 1.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPDeliverSMResponse.
	self assert: response header sequenceNumber equals: deliverSM header sequenceNumber.
	self assert: response header commandStatus equals: 0.
	self assert: response body messageId equals: '0'.