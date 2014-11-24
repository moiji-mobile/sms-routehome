as yet unclassified
remoteSCCPAddressForSRIForSM
	^(SCCPAddress createForSSN: #hlr)
			routedOnSSN: false;
			gtiFromAddr:  (SCCPGlobalTitleTranslation new
								nature: SCCPGlobalTitle naiInternationalNumber;
								plan: SCCPGlobalTitle npISDN;
								addr: msisdnE164 fromE164;
								translation: 0;
								yourself);
			yourself