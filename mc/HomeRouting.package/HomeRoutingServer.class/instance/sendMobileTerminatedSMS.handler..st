smpp
sendMobileTerminatedSMS: aMessage handler: aHandler
	| tpdu encoded rule |
	self
		logDebug: ('Server(<1p>) send MT-SMS from systemId(<2p>)' expandMacrosWith: mscNumber with: aHandler systemId) area: #home.

	tpdu := aMessage body toDeliverTPDUDictionary.
	rule := self ruleForMTSMS: aMessage.
	rule ifNil: [
		self
			logNotice: ('Server(<1p>) No MO-SMS rule found' expandMacrosWith: mscNumber) area: #home.
		^self smppReturnFailureOn: aHandler for: aMessage].
	encoded := ShortMessageTPDUHelper encodeDeliver: tpdu.
	HomeRoutingForwardDeliverSM new
		dialogueHandler: endPoint;
		hlr: self;
		hlrAddress: self hlrNumber;
		localSSN: #msc;
		msisdnE164: aMessage body destinationAddressAsGSM;
		sendRoutingInfoTranslationType: rule sendRoutingInfoTranslationType;
		forwardSMTranslationType: rule forwardSMTranslationType;
		remoteSSN: #hlr;
		smRPUI: encoded;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.