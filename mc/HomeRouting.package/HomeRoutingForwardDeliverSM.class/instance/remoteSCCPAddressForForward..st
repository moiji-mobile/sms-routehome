as yet unclassified
remoteSCCPAddressForForward: aNetworkNumber
	^(SCCPAddress createForSSN: #msc)
			routedOnSSN: false;
			gtiFromAddr:  (SCCPGlobalTitleTranslation new
								nature: SCCPGlobalTitle naiInternationalNumber;
								plan: SCCPGlobalTitle npISDN;
								addr: aNetworkNumber;
								translation: gtTranslation;
								yourself);
			yourself