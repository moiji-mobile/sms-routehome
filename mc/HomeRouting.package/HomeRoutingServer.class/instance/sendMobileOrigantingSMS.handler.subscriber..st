as yet unclassified
sendMobileOrigantingSMS: aMessage handler: aHandler subscriber: aSubscriber
	| tpdu encoded |
	tpdu := aMessage body toDeliverTPDUDictionary.
	encoded := HomeRoutingTPDUHelper encodeDeliver: tpdu.
	HomeRoutingForwardMTSM new
		dialogueHandler: endPoint;
		hlr: self;
		hlrAddress: self hlrNumber;
		remoteGlobalTitle: mscNumber;
		smRPUI: encoded;
		subscriber: aSubscriber;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.