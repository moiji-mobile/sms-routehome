as yet unclassified
mapMSISDN: aString
	"Map the MSISDN back to an IMSI"
	prefixPairs do: [:each |
		(aString beginsWith: each msisdnPrefix) ifTrue: [
			^each imsiPrefix, (aString allButFirst: each msisdnPrefix size)]].
	^nil
