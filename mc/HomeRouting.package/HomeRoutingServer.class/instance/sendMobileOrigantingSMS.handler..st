smpp
sendMobileOrigantingSMS: aMessage handler: aHandler
	| tpdu encoded rule |
	rule := self ruleForMOSMS: aMessage.
	rule ifNil: [^self smppReturnFailureOn: aHandler for: aMessage].
	
	tpdu := aMessage body toSubmitTPDUDictionary.
	encoded := HomeRoutingTPDUHelper encodeSubmit: tpdu.
	rule forwardSMOperation new
		dialogueHandler: endPoint;
		hlr: self;
		localSSN: #msc;
		hlrAddress: self hlrNumber;
		remoteGlobalTitle: rule smscNumber;
		remoteSSN: #msc;
		smRPUI: encoded;
		msisdnAsE164: aMessage body sourceAddressAsE164;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res.
			self smppMaybeSendDeliveryReceipt: aHandler for: aMessage];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.