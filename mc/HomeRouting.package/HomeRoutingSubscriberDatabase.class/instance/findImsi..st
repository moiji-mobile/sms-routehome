search
findImsi: anImsi
	| msisdn subscriber |
	msisdn := self mapIMSI: anImsi.

	"We don't have a subscriber?"
	msisdn ifNil: [^nil].

	subscriber := HomeRoutingSubscriber new
					imsi: anImsi;
					msisdn: msisdn;
					yourself.
	^self modifySubscriber: subscriber.