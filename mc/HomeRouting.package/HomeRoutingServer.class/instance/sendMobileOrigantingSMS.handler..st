smpp
sendMobileOrigantingSMS: aMessage handler: aHandler
	| tpdu encoded rule vp |
	self
		logDebug: ('Server(<1p>) send MO-SMS from systemId(<2p>)' expandMacrosWith: mscNumber with: aHandler systemId) area: #home.
	rule := self ruleForMOSMS: aMessage.
	rule ifNil: [
		self
			logNotice: ('Server(<1p>) No MO-SMS rule found' expandMacrosWith: mscNumber) area: #home.
		^self smppReturnFailureOn: aHandler for: aMessage].
	
	tpdu := aMessage body toSubmitTPDUDictionary.
	vp := rule validityPeriod.
	vp ifNotNil: [ 
		tpdu
			at: 'TP-VPFI' put: 2r10;
			at: 'TP-VP' put: (vp days + 166) asByteArray].
	
	encoded := ShortMessageTPDUHelper encodeSubmit: tpdu.
	rule forwardSMOperation new
		dialogueHandler: endPoint;
		hlr: self;
		localSSN: #msc;
		hlrAddress: self hlrNumber;
		remoteGlobalTitle: rule smscNumber;
		remoteSSN: #msc;
		smRPUI: encoded;
		msisdnAsE164: aMessage body sourceAddressAsGSM;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res.
			self smppMaybeSendDeliveryReceipt: aHandler for: aMessage];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.