baselines
baseline3: spec
	<version: '3'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/osmocom/Osmocom/main'.
		spec 
			project: 'Phexample' with: [
				spec
					className: #ConfigurationOfPhexample;
					versionString: '1.2';
					repository: 'http://smalltalkhub.com/mc/Phexample/Phexample/main' ];
			project: 'TCAP' with: [
				spec
					className: #ConfigurationOfTCAP;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Osmocom/main' ];
			project: 'ASN1' with: [
				spec
					className: #ConfigurationOfASN1;
					versionString: '0.8.26';
					repository: 'http://smalltalkhub.com/mc/NorbertHartl/ASN1/main' ];
			project: 'Osmocom' with: [
				spec
					className: #ConfigurationOfOsmocom;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Osmocom/main' ];
			project: 'RFB' with: [
				spec
					className: #ConfigurationOfRFB;
					versionString: '0.61';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/RFB/main' ];
			project: 'HLR' with: [
				spec
					className: #ConfigurationOfHLR;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Osmocom/main/' ].
		spec 
			package: 'SMPP-Codec' with: [
				spec requires: #('Osmocom' ). ];
			package: 'SMPP-Connection' with: [
				spec requires: #('SMPP-Codec' ). ];
			package: 'HomeRouting' with: [
				spec requires: #('TCAP' 'ASN1' 'SMPP-Codec' 'SMPP-Connection' 'HLR' ). ].
		spec group: 'default' with: #('HomeRouting' 'RFB' ). ].
