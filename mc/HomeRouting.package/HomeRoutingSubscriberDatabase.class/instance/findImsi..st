search
findImsi: anImsi
	| msisdn subscriber |

	self
		logDebug: ('Server(<1p>) searching for IMSI(<2p>)'
						expandMacrosWith: homeRoutingServer mscNumber with: anImsi) area: #home.	

	msisdn := self mapIMSI: anImsi.

	"We don't have a subscriber?"
	msisdn ifNil: [
		self
			logNotice: ('Server(<1p>) no subscriber for IMSI(<2p>)'
							expandMacrosWith: homeRoutingServer mscNumber with: anImsi) area: #home.
		^nil].

	self
		logDebug: ('Server(<1p>) using IMSI(<2p>)/MSISDN(<3p>)'
						expandMacrosWith: homeRoutingServer mscNumber with: anImsi with: msisdn) area: #home.	
	subscriber := HomeRoutingSubscriber new
					imsi: anImsi;
					msisdn: msisdn;
					yourself.
	^self modifySubscriber: subscriber.