smpp
selectSMPPConnection
	(smppConnection isNil not & smppConnection isConnected)
		ifTrue: [^smppConnection].
	smppConnectionManager ifNotNil: [^smppConnectionManager anyAuthenticatedConnection].
	^nil