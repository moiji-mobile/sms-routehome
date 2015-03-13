as yet unclassified
mapIMSI: aString 
	"Map the the IMSI to a MSISDN.."

	"Does it start with an IMSI we support?"
	prefixPairs do: [:each |
		(aString beginsWith: each imsiPrefix) ifTrue: [
			^each msisdnPrefix, (aString allButFirst: each imsiPrefix size)]].
	^nil