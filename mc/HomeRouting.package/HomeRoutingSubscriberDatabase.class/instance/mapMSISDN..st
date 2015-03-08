as yet unclassified
mapMSISDN: aString
	"Map the MSISDN back to an IMSI"
	(aString beginsWith: msisdnPrefix) ifFalse: [
		^nil].

	^imsiPrefix, (aString allButFirst: msisdnPrefix size)
