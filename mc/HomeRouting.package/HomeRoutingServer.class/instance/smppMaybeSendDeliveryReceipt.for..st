as yet unclassified
smppMaybeSendDeliveryReceipt: aHandler for: aMessage
	| smppCommand deliverSM |
	"Do we need to send a delivery report?"
	(aMessage body registeredDelivery = 1) ifFalse: [^self].

	deliverSM := SMPPDeliverSM new
		serviceType: '';
		sourceTypeOfNumber: aMessage body destinationTypeOfNumber;
		sourceNumberingPlanIndicator: aMessage body destinationNumberingPlanIndicator;
		sourceAddress: aMessage body destinationAddress;
		destinationTypeOfNumber: aMessage body sourceTypeOfNumber;
		destinationNumberingPlanIndicator: aMessage body sourceNumberingPlanIndicator;
		destinationAddress: aMessage body sourceAddress;
		esmClass: 16r04;
		protocolId: 0;
		priorityLevel: 0;
		scheduleDeliveryTime: '';
		validityPeriod: '';
		registeredDelivery: 0;
		dontReplaceIfPresent;
		defaultMessageID: 0;
		dataCoding: 0;
		shortMessage: (aMessage body deliveryReceiptString: DateAndTime now) asByteArray;
		userMessageReference: (aMessage body userMessageReference);
		messageState: #[2] "DELIVERED";
		receiptedMessageId: #[0];
		yourself.

	"We don't care about the result. Just send it."
	smppCommand := (SMPPCommand initWith: deliverSM)
		setTimeout: 80;
		yourself.
	aHandler scheduleCommand: smppCommand.