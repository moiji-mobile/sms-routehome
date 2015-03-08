as yet unclassified
testMapMSISDN

	self assert: (database mapMSISDN: '9123456') isNil.
	self assert: (database mapMSISDN: '12359999') equals: '4569999'.