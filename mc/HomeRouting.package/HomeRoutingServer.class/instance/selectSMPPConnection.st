smpp
selectSMPPConnection
	(smppConnection isNil not and: [ smppConnection isConnected])
		ifTrue: [^smppConnection].
	smppConnectionManager ifNotNil: [^smppConnectionManager anyAuthenticatedConnection].
	^nil