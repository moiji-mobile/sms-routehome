as yet unclassified
testSMPPUDHUCS2Extract
	| smpp extracted |
	smpp := SMPPMessage readFrom: #[0 0 0 202 0 0 0 4 0 0 0 0 174 2 0 0 0 1 1 51 53 52 51 56 53 49 48 48 49 55 48 0 1 1 52 54 55 48 50 57 57 53 52 48 52 0 64 0 1 0 0 0 0 8 0 140 5 0 3 249 3 1 0 64 0 163 0 36 0 165 0 232 0 233 0 249 0 236 0 242 0 199 0 32 0 216 0 248 0 32 0 197 0 229 0 10 3 148 0 95 3 166 3 147 3 155 3 169 3 160 3 168 3 163 3 152 3 158 0 32 0 198 0 230 3 178 0 201 0 10 0 32 0 33 0 34 0 35 0 32 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 10 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0 61 0 62 0 63 2 4 0 2 171 0] readStream.

	extracted := smpp body toSubmitTPDUDictionary.
	self assert: (extracted at: 'TP-UDHI').
	self assert: (extracted at: 'TP-UDH') equals: #[0 3 16rF9 3 1].
	self assert: (extracted at: 'TP-DCS') equals: 8.
	self assert: (extracted at: 'TP-UD-Len') equals: 140.
	self assert: (extracted at: 'TP-UD') equals: #[5 0 3 249 3 1 0 64 0 163 0 36 0 165 0 232 0 233 0 249 0 236 0 242 0 199 0 32 0 216 0 248 0 32 0 197 0 229 0 10 3 148 0 95 3 166 3 147 3 155 3 169 3 160 3 168 3 163 3 152 3 158 0 32 0 198 0 230 3 178 0 201 0 10 0 32 0 33 0 34 0 35 0 32 0 37 0 38 0 39 0 40 0 41 0 42 0 43 0 44 0 45 0 46 0 47 0 10 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0 61 0 62 0 63].