baselines
baseline2: spec
	<version: '2-baseline'>

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
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/NorbertHartl/ASN1/main' ];
			project: 'RFB' with: [
				spec
					className: #ConfigurationOfRFB;
					versionString: '0.63';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/RFB/main' ];
			project: 'HLR' with: [
				spec
					className: #ConfigurationOfHLR;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Osmocom/main/' ];
			project: 'OsmoGSM' with: [
				spec
					className: #ConfigurationOfOsmoGSM;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/GSM/main/' ];
			project: 'OsmoLogging' with: [
				spec
					className: #ConfigurationOfOsmoLogging;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Logging/main/' ];
			project: 'OsmoNetwork' with: [
				spec
					className: #ConfigurationOfOsmoNetwork;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Network/main/' ];
			project: 'SMPP' with: [
				spec
					className: #ConfigurationOfSMPP;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/SMPP/main/' ].
		spec package: 'HomeRouting' with: [
				spec requires: #('OsmoLogging' 'OsmoGSM' 'OsmoNetwork' 'ASN1' 'TCAP' 'HLR' 'SMPP' ). ].
		spec group: 'default' with: #('HomeRouting' 'RFB' ). ].
