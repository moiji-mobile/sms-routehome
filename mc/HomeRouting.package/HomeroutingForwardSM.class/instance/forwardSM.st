as yet unclassified
forwardSM
	| deliverSM  smppCommand imsi aSubscriber selectedSMPPConnection |
	
	self logDebug: ('ID(<1p>) Requested to forward SMS'
						expandMacrosWith: dialogue id) area: #home.

	selectedSMPPConnection := hlr selectSMPPConnection.
	selectedSMPPConnection ifNil: [
		self logError: ('ID(<1p>) No SMPPConnection. returning with sm-DeliveryFailure'
						expandMacrosWith: dialogue id) area: #home.
		invocation returnError: 'sm-DeliveryFailure' with: nil.
		^dialogue requestTcEnd: false.
	].

	"Check if the TO is a IMSI"
	imsi := invocation argument sm_RP_DA at: 'imsi' ifAbsent: [
		"Need to have an IMSI..."
		self logError: ('ID(<1p>) No IMSI inside sm_RP_DA'
						expandMacrosWith: dialogue id) area: #home.
		invocation returnError: 'unexpectedDataValue' with: nil.
		^dialogue requestTcEnd: false.
	].
	imsi := imsi fromTBCD.

	"TODO: Use the proper HLRDatabase interface"
	aSubscriber := hlr database findImsi: imsi.
	aSubscriber ifNil: [
		"Need to have a valid IMSI..."
		self logError: ('ID(<1p>) IMSI(<2s>) was not found as value in map'
						expandMacrosWith: dialogue id with: imsi) area: #home.
		invocation returnError: 'unexpectedDataValue' with: nil.
		^dialogue requestTcEnd: false.
	].

	deliverSM := self createDeliverSMFor: aSubscriber msisdn.
	deliverSM ifNil: [
		self logError: ('ID(<1p>) IMSI(<2s>) failed to create deliverSM SMPP PDU'
						expandMacrosWith: dialogue id with: imsi) area: #home.
		invocation returnError: 'sm-DeliveryFailure' with: nil.
		^dialogue requestTcEnd: false.
	].

	smppCommand := (SMPPCommand initWith: deliverSM)
		setTimeout: 80;
		onTimeout: [self smppTimeout];
		onResult: [:res | self smppResult];
		onError: [:err | self smppError];
		yourself.
	selectedSMPPConnection scheduleCommand: smppCommand.