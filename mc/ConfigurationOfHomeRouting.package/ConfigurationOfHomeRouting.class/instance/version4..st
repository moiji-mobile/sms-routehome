versions
version4: spec
	<version: '4' imports: #('4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 4'.
		spec author: 'NorbertHartl'.
		spec timestamp: '9/22/2015 20:57'.
		spec 
			project: 'Phexample' with: '1.2';
			project: 'TCAP' with: '5-baseline';
			project: 'ASN1' with: '0.8.28-baseline';
			project: 'RFB' with: '0.63';
			project: 'HLR' with: '4-baseline';
			project: 'OsmoGSM' with: '0.1-baseline';
			project: 'OsmoLogging' with: '0.1-baseline';
			project: 'OsmoNetwork' with: '0.1-baseline';
			project: 'SMPP' with: '0.1-baseline'.
		spec package: 'HomeRouting' with: 'HomeRouting-HolgerHansPeterFreyther.123'. ].
