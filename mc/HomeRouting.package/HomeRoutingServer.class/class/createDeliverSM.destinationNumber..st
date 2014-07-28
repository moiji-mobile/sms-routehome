as yet unclassified
createDeliverSM: anInvocation destinationNumber: destinationNumber

	| deliverSM sourceAddrs |

	sourceAddrs := self extractSourceAddress: anInvocation argument sm_RP_OA.
	sourceAddrs ifNil: [^nil].


	deliverSM := SMPPDeliverSM new.
	deliverSM
		serviceType: '';
		sourceTypeOfNumber: sourceAddrs first;
		sourceNumberingPlanIndicator: sourceAddrs second;
		sourceAddress: sourceAddrs third;
		destinationTypeOfNumber: 1;
		destinationNumberingPlanIndicator: 1;
		destinationAddress: destinationNumber;
		esmClass: 0;
		protocolId: 0;
		priorityLevel: 0;
		scheduleDeliveryTime: '';
		validityPeriod: '';
		registeredDelivery: 0;
		dontReplaceIfPresent;
		dataCoding: 0;
		defaultMessageID: 0;
		shortMessage: #[];
		messagePayload: (anInvocation argument sm_RP_UI) asByteArray.
		
	^deliverSM