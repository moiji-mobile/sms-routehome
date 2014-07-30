as yet unclassified
forwardSM: aDialogue invocation: anInvocation
	| deliverSM  smppCommand imsi destNumber selectedSMPPConnection |
	
	self logDebug: ('ID(<1s>) Requested to forward SMS'
						expandMacrosWith: aDialogue id) area: #home.

	selectedSMPPConnection := self selectSMPPConnection.
	selectedSMPPConnection ifNil: [
		self logError: ('ID(<1s>) No SMPPConnection. returning with sm-DeliveryFailure'
						expandMacrosWith: aDialogue id) area: #home.
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	"Check if the TO is a IMSI"
	imsi := anInvocation argument sm_RP_DA at: 'imsi' ifAbsent: [
		"Need to have an IMSI..."
		self logError: ('ID(<1s>) No IMSI inside sm_RP_DA'
						expandMacrosWith: aDialogue id) area: #home.
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].
	imsi := imsi fromTBCD.

	"Reverse look-up, probably too slow in the long run!"
	destNumber := subscriberMap keyAtValue: imsi ifAbsent: [
		"Need to have a valid IMSI..."
		self logError: ('ID(<1s>) IMSI(<2s>) was not found as value in map'
						expandMacrosWith: aDialogue id with: imsi) area: #home.
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].

	deliverSM := self createDeliverSM: anInvocation destinationNumber: destNumber.
	deliverSM ifNil: [
		self logError: ('ID(<1s>) IMSI(<2s>) failed to create deliverSM SMPP PDU'
						expandMacrosWith: aDialogue id with: imsi) area: #home.
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	smppCommand := (SMPPCommand initWith: deliverSM)
		onTimeout: [self smppTimeout: aDialogue invocation: anInvocation];
		onResult: [:res | self smppResult: aDialogue invocation: anInvocation];
		onError: [:err | self smppError: aDialogue invocation: anInvocation];
		yourself.
	selectedSMPPConnection scheduleCommand: smppCommand.