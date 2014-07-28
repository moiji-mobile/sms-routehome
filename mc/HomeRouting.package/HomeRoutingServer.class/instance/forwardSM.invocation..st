as yet unclassified
forwardSM: aDialogue invocation: anInvocation
	| deliverSM  smppCommand imsi destNumber |

	self isSMPPConnected ifFalse: [
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	"Check if the TO is a IMSI"
	imsi := anInvocation argument sm_RP_DA at: 'imsi' ifAbsent: [
		"Need to have an IMSI..."
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].
	imsi := imsi fromTBCD.

	"Reverse look-up, probably too slow in the long run!"
	destNumber := subscriberMap keyAtValue: imsi ifAbsent: [
		"Need to have a valid IMSI..."
		anInvocation returnError: 'unexpectedDataValue' with: nil.
		^aDialogue requestTcEnd: false.
	].

	deliverSM := self class createDeliverSM: anInvocation destinationNumber: destNumber.
	deliverSM ifNil: [
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	smppCommand := (SMPPCommand initWith: deliverSM)
		onTimeout: [self smppTimeout: aDialogue invocation: anInvocation];
		onResult: [:res | self smppResult: aDialogue invocation: anInvocation];
		onError: [:err | self smppError: aDialogue invocation: anInvocation];
		yourself.
	smppConnection scheduleCommand: smppCommand.