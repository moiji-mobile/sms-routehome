as yet unclassified
baseline1: spec 
        <version: '1-baseline'>
        
	spec for: #common do: [
		spec blessing: #baseline.
                spec repository: 'http://smalltalkhub.com/mc/osmocom/HomeRouting/main'.    
                spec 
				package: 'HomeRouting' with: [ spec requires: #('TCAP' 'ASN1' 'SMPP-Codec' 'SMPP-Connection') ].

			spec
				project: 'Phexample' with: [
					spec
						className: 'ConfigurationOfPhexample';
						versionString: '1.2';
						repository: 'http://smalltalkhub.com/mc/Phexample/Phexample/main' ].	
					
			spec
				project: 'TCAP' with: [
					spec
						className: 'ConfigurationOfTCAP';
						versionString: #'bleedingEdge';
						file: 'ConfigurationOfTCAP';
						repository: 'http://smalltalkhub.com/mc/osmocom/TCAP/main' ].

			spec
				project: 'ASN1' with: [
					spec
						className: 'ConfigurationOfASN1';
						versionString: #development;
						file: 'ConfigurationOfASN1';
						repository: 'http://smalltalkhub.com/mc/NorbertHartl/ASN1/main' ].

                spec
				package: 'SMPP-Codec' with: [ spec requires: #() ];
				package: 'SMPP-Connection' with: [ spec requires: #('SMPP-Codec') ].
                spec
				group: 'default' with: #('HomeRouting') ].