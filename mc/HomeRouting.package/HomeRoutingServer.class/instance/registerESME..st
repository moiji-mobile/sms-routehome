as yet unclassified
registerESME: aConnection
	"Only register to handle DeliverSM messages from the ESME but don't consider
	it for routing SubmitSM through the link"
	aConnection onUnhandledCommand: [:handler :command | self smppCommand: command from: handler].