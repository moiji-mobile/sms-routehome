as yet unclassified
handleSubmitSM: aMessage handler: aHandler
	"Start an Operation now"
	| tpdu encoded |
	tpdu := aMessage body toDeliverTPDUDictionary.
	encoded := HomeRoutingTPDUHelper encodeDeliver: tpdu.
	HomeRoutingForwardMTSM new
		dialogueHandler: endPoint;
		hlr: self;
		hlrAddress: self hlrNumber;
		remoteGlobalTitle: mscNumber;
		msisdn: aMessage body sourceAddress;
		smRPUI: encoded;
		onSuccess: [:res |
			self smppReturnSuccessOn: aHandler for: aMessage with: res];
		onFailure: [
			self smppReturnFailureOn: aHandler for: aMessage];
		execute.