search
findMSISDN: anMSISDN
	| imsi  subscriber |

	self
		logDebug: ('Server(<1p>) searching for MSISDN(<2p>)'
						expandMacrosWith: homeRoutingServer mscNumber with: anMSISDN) area: #home.	


	imsi := self mapMSISDN: anMSISDN.

	"We don't have a subscriber?"
	imsi ifNil: [
		self
			logNotice: ('Server(<1p>) no subscriber for MSISDN(<2p>)'
							expandMacrosWith: homeRoutingServer mscNumber with: anMSISDN) area: #home.
		^nil].

	self
		logDebug: ('Server(<1p>) using IMSI(<2p>)/MSISDN(<3p>)'
						expandMacrosWith: homeRoutingServer mscNumber with: imsi with: anMSISDN) area: #home.	
	subscriber := HomeRoutingSubscriber new
					imsi: imsi;
					msisdn: anMSISDN;
					yourself.
	^self modifySubscriber: subscriber.