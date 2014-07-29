smpp
reportUnhandled: tpdu
	Transcript
		nextPutAll: 'Can''t handle SMS like: ';
		nextPutAll: tpdu printString;
		cr
		