as yet unclassified
testExtractSubmitVP
	| inp extracted |
	inp := #[17 116 12 145 54 41 57 133 2 112 0 0 173 158 206 112 158 69 150 151 65 114 56 59 15 66 135 65 235 60 40 220 126 131 220 105 144 251 237 2 173 223 32 117 221 158 30 187 64 232 182 152 29 6 141 65 236 48 59 156 118 151 65 110 16 29 15 154 175 221 160 245 25 180 110 207 233 97 80 216 253 6 137 195 236 52 61 12 162 135 221 97 183 12 15 34 135 65 240 48 61 13 154 131 218 231 48 168 78 127 147 65 235 55 104 125 6 181 207 97 80 59 236 126 175 65 235 51 104 14 130 135 217 105 241 155 238 2 189 215 32 246 25 180 126 147 211 46 16 29 47 94 3].
	extracted := ShortMessageTPDUHelper extract: inp.
	self assert: (extracted at: 'TP-RP') equals: false.
	self assert: (extracted at: 'TP-UDHI') equals: false.
	self assert: (extracted at: 'TP-SRR') equals: false.
	self assert: (extracted at: 'TP-VPFI') equals: 2.
	self assert: (extracted at: 'TP-RD') equals: true.
	self assert: (extracted at: 'TP-MTI') equals: 1.
	self assert: (extracted at: 'TP-MR') equals: 116.

	self assert: (extracted at: 'npi') equals: 1.
	self assert: (extracted at: 'ton') equals: 1.
	self assert: (extracted at: 'TP-DA') equals: '639293582007'.
	self assert: (extracted at: 'TP-DCS') equals: 0.
	self assert: (extracted at: 'TP-VP') equals: #[16rAD].
	self assert: (extracted at: 'TP-UD') equals: #[206 112 158 69 150 151 65 114 56 59 15 66 135 65 235 60 40 220 126 131 220 105 144 251 237 2 173 223 32 117 221 158 30 187 64 232 182 152 29 6 141 65 236 48 59 156 118 151 65 110 16 29 15 154 175 221 160 245 25 180 110 207 233 97 80 216 253 6 137 195 236 52 61 12 162 135 221 97 183 12 15 34 135 65 240 48 61 13 154 131 218 231 48 168 78 127 147 65 235 55 104 125 6 181 207 97 80 59 236 126 175 65 235 51 104 14 130 135 217 105 241 155 238 2 189 215 32 246 25 180 126 147 211 46 16 29 47 94 3].