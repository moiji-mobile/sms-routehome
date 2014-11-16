as yet unclassified
formatGSM7Bit: tpdu on: smppMessage
	| data bytes udhi |
	data := #[] toMessage.
	
	udhi  := tpdu at: 'TP-UDHI'.
	udhi ifTrue: [
		| udh |
		"Indicate we have a UDH here and assume we know the rest of the class"
		udh := (tpdu at: 'TP-UDH').
		smppMessage esmClass: 2r01000000.
		data
			putByte: udh size;
			putByteArray: udh.
	].
		
	"The last 7bit of the TP-UDH might be empty and this is why there is
	a TP-UD-Len so one can know if the last '0' belongs to the SMS or not.
	We need to truncate the bytearray here and abuse a feature of Squeak
	at this point. To use >>#next:"
	bytes := #[] toMessage.
	bytes
		putByteArray: data;
		putByteArray: (tpdu at: 'TP-UD').
	bytes := GSMDecoding expand: bytes.
	bytes := bytes readStream next: (tpdu at: 'TP-UD-Len').
		
	"With TP-UDHI and 7bit encoding there are some bytes we need to
	skip and re-do now."
	udhi ifTrue: [
		| skip fillBits |
		"Now we need to skip the n-octets of the header and maybe from
		the fill bit as well and put back the original data again."
		skip := (((data size)* 8) \\ 7).
		fillBits := 7 - skip.
		fillBits > 0
			ifTrue: [skip := skip + 1].

		data
			putByteArray: (bytes allButFirst: skip).
		bytes := data.
	].

	smppMessage
		dataCoding: 0;
		shortMessage: bytes asByteArray