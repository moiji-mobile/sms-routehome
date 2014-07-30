as yet unclassified
forwardSM: aDialogue invocation: anInvocation
	| deliverSM  smppCommand imsi destNumber selectedSMPPConnection |
	
	self logDebug: 'Requested to forward SMS' area: #home.

	selectedSMPPConnection := self selectSMPPConnection.
	selectedSMPPConnection ifNil: [
		self logError: 'No SMPPConnection. returning with sm-DeliveryFailure' area: #home.
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	"Check if the TO is a IMSI"
	imsi := anInvocation argument sm_RP_DA at: 'imsi' ifAbsent: [
		"Need to have an IMSI..."
		self logError: 'No IMSI inside sm_RP_DA' area: #home.
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].
	imsi := imsi fromTBCD.

	"Reverse look-up, probably too slow in the long run!"
	destNumber := subscriberMap keyAtValue: imsi ifAbsent: [
		"Need to have a valid IMSI..."
		self logError: ('IMSI(<1s>) was not found as value in map' expandMacrosWith: imsi) area: #home.
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].

	deliverSM := self createDeliverSM: anInvocation destinationNumber: destNumber.
	deliverSM ifNil: [
		self logError: ('IMSI(<1s>) failed to create deliverSM SMPP PDU' expandMacrosWith: imsi) area: #home.
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	smppCommand := (SMPPCommand initWith: deliverSM)
		onTimeout: [self smppTimeout: aDialogue invocation: anInvocation];
		onResult: [:res | self smppResult: aDialogue invocation: anInvocation];
		onError: [:err | self smppError: aDialogue invocation: anInvocation];
		yourself.
	selectedSMPPConnection scheduleCommand: smppCommand.