as yet unclassified
forwardSM: aDialogue invocation: anInvocation origin: oAddress destination: dAddress payload: data
	| deliverSM  smppCommand |

	self isSMPPConnected ifFalse: [
		anInvocation returnError: 'sm-DeliveryFailure' with: nil.
		^aDialogue requestTcEnd: false.
	].

	"TODO validate that the SMSC and the IMSI are ours!"
	self flag: #todo.

	deliverSM := self class createDeliverSM: anInvocation.
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