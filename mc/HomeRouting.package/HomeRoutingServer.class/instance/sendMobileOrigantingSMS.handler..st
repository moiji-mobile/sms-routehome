smpp
sendMobileOrigantingSMS: aMessage handler: aHandler
	| tpdu encoded remoteGlobalTitle |
	remoteGlobalTitle := self gtForDestination: aMessage.
	remoteGlobalTitle ifNil: [^self smppReturnFailureOn: aHandler for: aMessage].
	
	tpdu := aMessage body toSubmitTPDUDictionary.
	encoded := HomeRoutingTPDUHelper encodeSubmit: tpdu.
	HomeRoutingForwardSubmitSMV2 new
		dialogueHandler: endPoint;
		hlr: self;
		localSSN: #msc;
		hlrAddress: self hlrNumber;
		remoteGlobalTitle: remoteGlobalTitle;
		remoteSSN: #msc;
		smRPUI: encoded;
		msisdnAsE164: aMessage body sourceAddressAsE164;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res.
			self smppMaybeSendDeliveryReceipt: aHandler for: aMessage];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.