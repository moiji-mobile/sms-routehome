versions
version2: spec
	<version: '2' imports: #('2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'NorbertHartl'.
		spec timestamp: '2/12/2014 15:19'.
		spec 
			project: 'Phexample' with: '1.2';
			project: 'TCAP' with: '0.2.1';
			project: 'ASN1' with: '0.8.26'.
		spec 
			package: 'HomeRouting' with: 'HomeRouting-HolgerHansPeterFreyther.13';
			package: 'SMPP-Codec' with: 'SMPP-Codec-HolgerHansPeterFreyther.1';
			package: 'SMPP-Connection' with: 'SMPP-Connection-HolgerHansPeterFreyther.1' ].
