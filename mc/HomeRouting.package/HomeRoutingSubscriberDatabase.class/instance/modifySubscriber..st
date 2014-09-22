as yet unclassified
modifySubscriber: aSubscriber
	| smppConnection |

	"To deal with sendRoutingInfoForSM we need to manage the availability
	and we want to get away without a message waiting list. So we will need
	to check here if there is a SMPPConnection"
	aSubscriber ifNil: [^nil].

	"TODO: Place the SMPP Connection inside the Subscriber for the
	rare moment of the connection vanishing while this code is execution
	but Pharo doesn't seem to have preemption like this yet."
	smppConnection := homeRoutingServer selectSMPPConnection.
	smppConnection isNil
		ifTrue: [aSubscriber clearVlr]
		ifFalse: [
			aSubscriber
				vlrNumber: homeRoutingServer mscNumber;
				mscNumber: homeRoutingServer mscNumber].
	^aSubscriber