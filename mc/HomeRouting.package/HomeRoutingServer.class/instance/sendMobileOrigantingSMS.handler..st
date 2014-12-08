smpp
sendMobileOrigantingSMS: aMessage handler: aHandler
	| tpdu encoded |
	tpdu := aMessage body toSubmitTPDUDictionary.
	encoded := HomeRoutingTPDUHelper encodeSubmit: tpdu.
	HomeRoutingForwardSubmitSMV2 new
		dialogueHandler: endPoint;
		hlr: self;
		localSSN: #msc;
		hlrAddress: self hlrNumber;
		remoteGlobalTitle: (self gtForDestination: aMessage body);
		remoteSSN: #msc;
		smRPUI: encoded;
		msisdnAsE164: aMessage body sourceAddressAsE164;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res.
			self smppMaybeSendDeliveryReceipt: aHandler for: aMessage];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.