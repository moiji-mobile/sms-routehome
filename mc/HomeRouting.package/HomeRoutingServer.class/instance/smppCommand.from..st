smpp
smppCommand: aSmppMessage from: aHandler
	aSmppMessage body homeRouterDispatchCommand: aSmppMessage handler: aHandler on: self