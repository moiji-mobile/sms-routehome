as yet unclassified
extractDestAddress: aDictionary 
	"SM-RP-DA choice type. We only support IMSI right now"
	aDictionary at: 'imsi' ifPresent: [:addr |
		"E212 number"
		^Array with: 1 with: 6 with: addr fromTBCD.
	].

	^nil