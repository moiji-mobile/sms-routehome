as yet unclassified
createDeliverSM: anInvocation

	| deliverSM sourceAddrs destAddrs |

	sourceAddrs := self extractSourceAddress: anInvocation argument sm_RP_OA.
	sourceAddrs ifNil: [^nil].
	
	destAddrs := self extractDestAddress: anInvocation argument sm_RP_DA.
	destAddrs ifNil: [^nil].

	deliverSM := SMPPDeliverSM new.
	deliverSM
		serviceType: '';
		sourceTypeOfNumber: sourceAddrs first;
		sourceNumberingPlanIndicator: sourceAddrs second;
		sourceAddress: sourceAddrs third;
		destinationTypeOfNumber: destAddrs first;
		destinationNumberingPlanIndicator: destAddrs second;
		destinationAddress: destAddrs third;
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