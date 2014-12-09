smpp
sendMobileTerminatedSMS: aMessage handler: aHandler
	| tpdu encoded rule |
	tpdu := aMessage body toDeliverTPDUDictionary.
	rule := self ruleForMTSMS: aMessage.
	rule ifNil: [
		^self smppReturnFailureOn: aHandler for: aMessage].
	encoded := HomeRoutingTPDUHelper encodeDeliver: tpdu.
	HomeRoutingForwardDeliverSM new
		dialogueHandler: endPoint;
		hlr: self;
		hlrAddress: self hlrNumber;
		localSSN: #msc;
		msisdnE164: aMessage body destinationAddressAsE164;
		sendRoutingInfoTranslationType: rule sendRoutingInfoTranslationType;
		forwardSMTranslationType: rule forwardSMTranslationType;
		remoteSSN: #hlr;
		smRPUI: encoded;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.