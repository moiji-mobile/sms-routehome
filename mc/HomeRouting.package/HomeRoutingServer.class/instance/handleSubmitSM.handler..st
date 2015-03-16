smpp
handleSubmitSM: aMessage handler: aHandler
	self
		logDebug: ('Server(<1p>) handleSubmitSM systemId(<2p>)' expandMacrosWith: mscNumber with: aHandler systemId) area: #home.
	self sendMobileOrigantingSMS: aMessage handler: aHandler