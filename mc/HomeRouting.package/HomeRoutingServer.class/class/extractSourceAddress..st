as yet unclassified
extractSourceAddress: aDictionary
	"This is the SM-RP-DA Choice type but we only support one of them right now"
	aDictionary at: 'serviceCentreAddressOA' ifPresent: [:addr |
		| ba ton npi num |
		ba := (ByteArray readHexFrom: addr) first.
		ton := (ba bitShift: -4) bitAnd: 2r0111.
		npi := ba bitAnd: 2r1111.
		num := addr fromE164.
		^Array with: ton with: npi with: num.
	].

	^nil