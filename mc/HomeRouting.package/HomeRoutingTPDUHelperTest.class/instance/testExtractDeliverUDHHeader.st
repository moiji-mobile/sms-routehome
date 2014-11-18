as yet unclassified
testExtractDeliverUDHHeader
	| inp extracted |
	inp := ByteArray readHexFrom: '640c91533458001091000041804031016000a0050003d90201a2f7b29c9eafa7dff0f9dc4c3e9fd16b36dbed1ee3f1ee76fbbd76bb586490596606e1f178d07c8e06a5f3f5b39a9c4e9fcfe4b4fa8c9ed7d3e8391a9d9ea36b38994c60328546bdd56fb74ba1509bb2aab4416d521bdec6a776bb91c8a9326bb41685cae55469b54e914ae554683d56a7caa91269454e975aa5f5383d2aa74aab70aa9c2e85'.
	extracted := HomeRoutingTPDUHelper extract: inp.
	self assert: (extracted at: 'TP-RP') equals: false.
	self assert: (extracted at: 'TP-UDHI') equals: true.
	self assert: (extracted at: 'TP-SRI') equals: true.
	self deny: (extracted at: 'TP-MMS').
	self assert: (extracted at: 'TP-MTI') equals: 0.

	self assert: (extracted at: 'npi') equals: 1.
	self assert: (extracted at: 'ton') equals: 1.
	self assert: (extracted at: 'TP-OA') equals: '354385000119'.
	self assert: (extracted at: 'TP-DCS') equals: 0.
	self assert: (extracted at: 'TP-SCTS') equals: #[65 128 64 49 1 96 0].
	self assert: (extracted at: 'TP-UDH') equals: #[0 3 217 2 1 ].
	self assert: (extracted at: 'TP-UD') equals: #[162 247 178 156 158 175 167 223 240 249 220 76 62 159 209 107 54 219 237 30 227 241 238 118 251 189 118 187 88 100 144 89 102 6 225 241 120 208 124 142 6 165 243 245 179 154 156 78 159 207 228 180 250 140 158 215 211 232 57 26 157 158 163 107 56 153 76 96 50 133 70 189 213 111 183 75 161 80 155 178 170 180 65 109 82 27 222 198 167 118 187 145 200 169 50 107 180 22 133 202 229 84 105 181 78 145 74 229 84 104 61 86 167 202 169 18 105 69 78 151 90 165 245 56 61 42 167 74 171 112 170 156 46 133].
	self assert: (extracted at: 'TP-UD-Len') equals: 160.