as yet unclassified
testFormatForDeliverSM
	| extracted deliverSM |
	extracted := HomeRoutingTPDUExtractor extract: #[100 12 145 83 52 88 0 16 145 0 0 65 128 64 49 1 96 0 160 5 0 3 217 2 1 162 247 178 156 158 175 167 223 240 249 220 76 62 159 209 107 54 219 237 30 227 241 238 118 251 189 118 187 88 100 144 89 102 6 225 241 120 208 124 142 6 165 243 245 179 154 156 78 159 207 228 180 250 140 158 215 211 232 57 26 157 158 163 107 56 153 76 96 50 133 70 189 213 111 183 75 161 80 155 178 170 180 65 109 82 27 222 198 167 118 187 145 200 169 50 107 180 22 133 202 229 84 105 181 78 145 74 229 84 104 61 86 167 202 169 18 105 69 78 151 90 165 245 56 61 42 167 74 171 112 170 156 46 133].

	deliverSM := SMPPDeliverSM new.
	res := server formatForDeliverSM: extracted on: deliverSM.
	self deny: res isNil.
	self assert: res sarMessageReferenceNumber equals: nil.
	self assert: res sarTotalSegments equals: nil.
	self assert: res sarSegmentNumber equals: nil.

	"We expect it to be inside user data."
	self assert: deliverSM esmClass equals: 64.
	self assert: deliverSM shortMessage size equals: 159.

	"Encode just to see if there is an exception"
	res toMessage asByteArray.
	
	