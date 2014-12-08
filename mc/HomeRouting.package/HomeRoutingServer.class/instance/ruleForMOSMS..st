mo-routing
ruleForMOSMS: aDestination
	moSmsConfigRules do: [:each |
		(each match: aDestination) ifTrue: [^each]].
	^nil