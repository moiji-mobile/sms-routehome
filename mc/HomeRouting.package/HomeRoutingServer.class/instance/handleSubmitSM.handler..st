as yet unclassified
handleSubmitSM: aMessage handler: aHandler
	"Start an Operation now"
	database newQuery
		msisdn: aMessage body sourceAddress;
		onSuccess: [:subscriber |
			self sendMobileOrigantingSMS: aMessage handler: aHandler subscriber: subscriber];
		onFailure: [:reason |
			self smppReturnFailureOn: aHandler for: aMessage];
		start.