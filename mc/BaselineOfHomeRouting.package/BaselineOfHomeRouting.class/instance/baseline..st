as yet unclassified
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec
			baseline: 'HLR' with: [
				spec
					repository: 'github://moiji-mobile/hlr/mc';
					loads: 'core'];
			project: 'TCAP' with: [
				spec
					className: #ConfigurationOfTCAP;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/TCAP/main' ];
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
					repository: 'http://smalltalkhub.com/mc/osmocom/SMPP/main/' ];
			project: 'StatsDClient' with: [
				spec
					className: #ConfigurationOfStatsDClient;
					versionString: '2';
					repository: 'http://smalltalkhub.com/mc/hfreyther2/StatsD/main/' ];
			project: 'ShortMessage' with: [
				spec
					className: #ConfigurationOfShortMessage;
					versionString: '1';
					repository: 'http://smalltalkhub.com/mc/osmocom/ShortMessage/main/' ].
		spec package: 'HomeRouting' with: [
				spec requires: #('OsmoLogging' 'OsmoGSM' 'OsmoNetwork' 'ASN1' 'TCAP' 'HLR' 'SMPP' 'StatsDClient' 'ShortMessage' ). ].
		spec group: 'default' with: #('HomeRouting' 'RFB' ). ].
