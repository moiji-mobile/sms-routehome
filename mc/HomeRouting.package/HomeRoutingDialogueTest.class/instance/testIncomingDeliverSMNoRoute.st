as yet unclassified
testIncomingDeliverSMNoRoute
	| deliverSM response mapReqSRI mapReqFwd |

	"Clear routes"
	testHomeRouting clearMTSMSRules.

	"Check if we receive a forwardSM.."
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
				| isSRIForSM isFwdSM |
				isSRIForSM := tcapNotify invocation operationName = 'sendRoutingInfoForSMV2'.
				isFwdSM := tcapNotify invocation operationName = 'forwardSM'.
				isSRIForSM ifTrue: [
					mapReqSRI := tcapNotify invocation.
					tcapNotify returnResultLastUsing: [ :item |
						item
							at: 'imsi' put: '1234' toTBCD;
							expandAt: 'locationInfoWithLMSI' using: [ :infoLmsi |
								infoLmsi at: 'networkNode-Number' put: '4321' toE164 ] ].
					diag requestTcEnd: false].
				isFwdSM ifTrue: [
					mapReqFwd := tcapNotify invocation.
					tcapNotify returnResultLast: nil.
					diag requestTcEnd: false]]].

	deliverSM := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	smppConnection handler dispatchMessage: deliverSM.
	
	"Assert we received a mapRequest"
	self assert: mapReqSRI isNil.
	self assert: mapReqFwd isNil.

	"We expect that we received an error for the submitSM"
	self assert: smppConnection sent size equals: 1.
	response := SMPPMessage readFrom: smppConnection sent first readStream.
	self deny: response body isCommand.
	self assert: response body class equals: SMPPDeliverSMResponse.
	self assert: response header sequenceNumber equals: deliverSM header sequenceNumber.
	self assert: response header commandStatus equals: 8.
	self assert: response body messageId equals: ''.