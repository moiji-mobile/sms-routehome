smpp
sendMobileOrigantingSMS: aMessage handler: aHandler
	| tpdu encoded rule vp |
	rule := self ruleForMOSMS: aMessage.
	rule ifNil: [^self smppReturnFailureOn: aHandler for: aMessage].
	
	tpdu := aMessage body toSubmitTPDUDictionary.
	vp := rule validityPeriod.
	vp ifNotNil: [ 
		tpdu
			at: 'TP-VPFI' put: 2r10;
			at: 'TP-VP' put: (vp days + 166) asByteArray].
	
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