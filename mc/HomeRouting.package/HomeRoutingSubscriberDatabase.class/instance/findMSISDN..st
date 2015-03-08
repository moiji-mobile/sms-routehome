search
findMSISDN: anMSISDN
	| imsi  subscriber |
	imsi := self mapMSISDN: anMSISDN.

	"We don't have a subscriber?"
	imsi ifNil: [^nil].

	subscriber := HomeRoutingSubscriber new
					imsi: imsi;
					msisdn: anMSISDN;
					yourself.
	^self modifySubscriber: subscriber.