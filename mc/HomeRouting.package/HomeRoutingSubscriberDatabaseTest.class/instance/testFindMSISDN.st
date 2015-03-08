tests-search
testFindMSISDN

	self assert: (database findMSISDN: '9999') isNil.
	self deny: (database findMSISDN: '1235999') isNil.