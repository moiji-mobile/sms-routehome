smpp
sendMobileTerminatedSMS: aMessage handler: aHandler
	| tpdu encoded |
	tpdu := aMessage body toDeliverTPDUDictionary.
	encoded := HomeRoutingTPDUHelper encodeDeliver: tpdu.
	HomeRoutingForwardDeliverSM new
		dialogueHandler: endPoint;
		hlr: self;
		hlrAddress: self hlrNumber;
		localSSN: #msc;
		msisdnE164: aMessage body destinationAddressAsE164;
		gtTranslation: (self gtTranslationForDestination: aMessage body);
		remoteSSN: #hlr;
		smRPUI: encoded;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.