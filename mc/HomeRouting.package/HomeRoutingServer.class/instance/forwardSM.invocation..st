as yet unclassified
forwardSM: aDialogue invocation: anInvocation
	| deliverSM  smppCommand imsi aSubscriber selectedSMPPConnection |
	
	self logDebug: ('ID(<1p>) Requested to forward SMS'
						expandMacrosWith: aDialogue id) area: #home.

	selectedSMPPConnection := self selectSMPPConnection.
	selectedSMPPConnection ifNil: [
		self logError: ('ID(<1p>) No SMPPConnection. returning with sm-DeliveryFailure'
						expandMacrosWith: aDialogue id) area: #home.
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	"Check if the TO is a IMSI"
	imsi := anInvocation argument sm_RP_DA at: 'imsi' ifAbsent: [
		"Need to have an IMSI..."
		self logError: ('ID(<1p>) No IMSI inside sm_RP_DA'
						expandMacrosWith: aDialogue id) area: #home.
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].
	imsi := imsi fromTBCD.

	"Reverse look-up, probably too slow in the long run!"
	aSubscriber := database findImsi: imsi.
	aSubscriber ifNil: [
		"Need to have a valid IMSI..."
		self logError: ('ID(<1p>) IMSI(<2s>) was not found as value in map'
						expandMacrosWith: aDialogue id with: imsi) area: #home.
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].

	deliverSM := self createDeliverSM: anInvocation destinationNumber: aSubscriber msisdn.
	deliverSM ifNil: [
		self logError: ('ID(<1p>) IMSI(<2s>) failed to create deliverSM SMPP PDU'
						expandMacrosWith: aDialogue id with: imsi) area: #home.
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	smppCommand := (SMPPCommand initWith: deliverSM)
		setTimeout: 80;
		onTimeout: [self smppTimeout: aDialogue invocation: anInvocation];
		onResult: [:res | self smppResult: aDialogue invocation: anInvocation];
		onError: [:err | self smppError: aDialogue invocation: anInvocation];
		yourself.
	selectedSMPPConnection scheduleCommand: smppCommand.