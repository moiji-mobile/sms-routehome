as yet unclassified
testIncomingDeliverSM
	| deliverSM response mapReqSRI mapReqFwd inDiag |

	"Check if we receive a forwardSM.."
	testEndPoint
		onDialogue: [:diag |
			inDiag := diag.
			diag onInvoke: [:tcapNotify |
				| isSRIForSM isFwdSM result |
				isSRIForSM := tcapNotify invocation operationName = 'sendRoutingInfoForSMV2'.
				isFwdSM := tcapNotify invocation operationName = 'forwardSM'.
				isSRIForSM ifTrue: [
					mapReqSRI := tcapNotify invocation.
					result := mapReqSRI resultValue.
					result at: 'imsi' put: '1234' toTBCD.
					(result expandFieldNamed: 'locationInfoWithLMSI')
						at: 'networkNode-Number' put: '4321' toE164.
					tcapNotify returnResultLast: result.
					diag requestTcEnd: false].
				isFwdSM ifTrue: [
					mapReqFwd := tcapNotify invocation.
					tcapNotify returnResultLast: nil.
					diag requestTcEnd: false]]].

	deliverSM := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	smppConnection handler dispatchMessage: deliverSM.
	
	"Assert we received a mapRequest"
	self deny: mapReqSRI isNil.
	self assert: mapReqSRI operationName equals: 'sendRoutingInfoForSMV2'.
	self assert: mapReqSRI argument sm_RP_PRI.
	self deny: mapReqFwd isNil.
	self assert: mapReqFwd operationName equals: 'forwardSM'.
	self assert: inDiag applicationContextName equals: '0.4.0.0.1.0.25.2' asAsn1Oid.

	"We expect that we received an error for the submitSM"
	self assert: smppConnection sent size equals: 1.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPDeliverSMResponse.
	self assert: response header sequenceNumber equals: deliverSM header sequenceNumber.
	self assert: response header commandStatus equals: 0.
	self assert: response body messageId equals: ''.