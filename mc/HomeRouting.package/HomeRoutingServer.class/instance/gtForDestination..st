mo-routing
gtForDestination: aDestination
	moSmsConfigRules do: [:each |
		(each match: aDestination) ifTrue: [^each smscNumber]].
	^nil