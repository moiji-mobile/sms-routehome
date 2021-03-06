as yet unclassified
testFormatForDeliverSM
	| extracted deliverSM |
	extracted := ShortMessageTPDUHelper extract: #[64 12 129 83 52 88 0 16 145 0 0 65 128 112 49 1 117 0 160 5 0 3 168 2 1 226 247 178 156 158 175 167 223 240 95 120 78 54 159 209 234 53 251 247 211 227 199 118 177 187 29 189 22 165 212 108 53 249 132 254 130 83 162 241 136 84 46 153 191 159 22 59 180 10 157 205 152 108 70 171 217 110 184 28 44 126 47 203 233 249 122 250 13 255 133 231 100 243 25 173 94 179 127 63 61 126 108 23 187 219 49 217 140 86 179 221 112 57 88 244 90 148 82 179 213 228 19 250 11 78 137 198 35 82 185 100 254 126 90 236 208 42 116 54 99 178 25 173 102 187 225 114 176 248 189 44 167 231 235].

	deliverSM := SMPPDeliverSM new.
	res := server formatForDeliverSM: extracted on: deliverSM.
	self deny: res isNil.
	self assert: res sarMessageReferenceNumber equals: nil.
	self assert: res sarTotalSegments equals: nil.
	self assert: res sarSegmentNumber equals: nil.

	"We expect it to be inside user data."
	self assert: deliverSM esmClass equals: 64.
	self assert: (deliverSM shortMessage first: 6) equals: #[5 0 3 168 2 1].
	self assert: (deliverSM shortMessage allButFirst: 6) asString equals: 'qwertyuiop?asdfghjkl??zxcvbnmQWERTYUIOP?ASDFGHJKL??ZXCVBNM1234567890qwertyuiop?asdfghjkl??zxcvbnm1234567890QWERTYUIOP?ASDFGHJKL??ZXCVBNM1234567890qwertyu'.
	self assert: deliverSM shortMessage size equals: 159.
	
	