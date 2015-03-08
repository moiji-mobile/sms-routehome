as yet unclassified
mapIMSI: aString 
	"Map the the IMSI to a MSISDN.."

	"Does it start with an IMSI we support?"
	(aString beginsWith: imsiPrefix) ifFalse: [
		^nil].

	^msisdnPrefix, (aString allButFirst: imsiPrefix size)