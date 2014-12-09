mt-routing
ruleForMTSMS: aMessage
	mtSmsConfigRules do: [:rule |
		(rule match: aMessage) ifTrue: [^rule]].
	^nil