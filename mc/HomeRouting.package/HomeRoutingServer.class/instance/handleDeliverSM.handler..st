smpp
handleDeliverSM: aMessage handler: aHandler
	self
		logDebug: ('Server(<1p>) handleDeliverSM systemId(<2p>)' expandMacrosWith: mscNumber with: aHandler systemId) area: #home.
	self sendMobileTerminatedSMS: aMessage handler: aHandler