tests-search
testFindImsi

	self assert: (database findImsi: '9999') isNil.
	self deny: (database findImsi: '456123') isNil.