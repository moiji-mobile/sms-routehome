as yet unclassified
createDeliverSMFor: destinationNumber
	| deliverSM  tpdu |
	
	"Extract information from the deliverSM"
	[
		| smRPUI |
		smRPUI := invocation argument sm_RP_UI.
		tpdu := ShortMessageTPDUHelper extract: smRPUI.
	] on: Error do: [:err |
		err logException: ('Dest(<1s>) couldn''t parse TPDU' expandMacrosWith: destinationNumber) area: #home.
		^nil
	].

	deliverSM := SMPPDeliverSM new.
	deliverSM
		serviceType: '';
		sourceTypeOfNumber: (tpdu at: 'ton');
		sourceNumberingPlanIndicator: (tpdu at: 'npi');
		sourceAddress: (tpdu at: 'TP-OA');
		destinationTypeOfNumber: 1;
		destinationNumberingPlanIndicator: 1;
		destinationAddress: destinationNumber;
		priorityLevel: 0;
		scheduleDeliveryTime: '';
		validityPeriod: '';
		registeredDelivery: 0;
		dontReplaceIfPresent;
		defaultMessageID: 0;
		yourself.

	^ self formatForDeliverSM: tpdu on: deliverSM.