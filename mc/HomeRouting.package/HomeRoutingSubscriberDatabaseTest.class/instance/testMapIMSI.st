as yet unclassified
testMapIMSI

	self assert: (database mapIMSI: '123456') isNil.
	self assert: (database mapIMSI: '4569999') equals: '12359999'.