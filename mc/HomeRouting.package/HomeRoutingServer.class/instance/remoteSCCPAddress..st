alert
remoteSCCPAddress: aSmscAddress
	^ (SCCPAddress createForSSN: #msc)
		routedOnSSN: false;
		gtiFromAddr:  (SCCPGlobalTitleTranslation new
							nature: SCCPGlobalTitle naiInternationalNumber;
							plan: SCCPGlobalTitle npISDN;
							addr: aSmscAddress;
							translation: 0;
							yourself);
		yourself