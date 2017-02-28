SMS Homerouting [![Build Status](https://travis-ci.org/moiji-mobile/sms-routehome.svg?branch=master)](https://travis-ci.org/moiji-mobile/sms-routehome) [![Test Status](https://api.bob-bench.org/v1/badgeByUrl?branch=master&hosting=github&ci=travis-ci&repo=moiji-mobile%2Fsms-routehome)](https://bob-bench.org/r/gh/moiji-mobile/sms-routehome)
=====

This application will handle the GSM MAP sendRoutingInfoForSM operation
and responde with a fixed GT and a pseudo IMSI. It can handle the
incoming mt-ForwardSM/forwardSM operation and convert it to a SMPP
DeliverSM operation.

The code is based on a commercial grade Free Software TCAP stack and
is re-using infrastructure of the [HLR](https://github.com/moiji-mobile/hlr).
