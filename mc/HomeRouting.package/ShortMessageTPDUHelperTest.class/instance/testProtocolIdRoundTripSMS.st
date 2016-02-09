as yet unclassified
testProtocolIdRoundTripSMS
	| inp extracted out |

	"Begin with a deliver"
 	inp := #[4 11 145 51 102 2 19 69 244 1 0 65 112 113 129 4 113 128 6 210 114 185 92 70 3].
	extracted := ShortMessageTPDUHelper extract: inp.
	self assert: (extracted at: 'TP-PID') equals: 1.
	out := ShortMessageTPDUHelper encodeDeliver: extracted.
	self assert: out equals: inp.

	inp :=  #[1 12 15 129 0 148 81 135 134 120 70 245 1 0 9 204 183 189 12 202 191 235 32].
	extracted := ShortMessageTPDUHelper extract: inp.
	self assert: (extracted at: 'TP-PID') equals: 1.
	out := ShortMessageTPDUHelper encodeSubmit: extracted.
	self assert: out equals: inp.