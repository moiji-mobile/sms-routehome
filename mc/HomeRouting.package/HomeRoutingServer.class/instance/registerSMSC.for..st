as yet unclassified
registerSMSC: smscAddress for: anEncodedMSISDN
	pendingAlerts add: (HomeRoutingAlertEntry smscAddress: smscAddress with: anEncodedMSISDN).