var q=require('\x71');var controlhubBaseUrl='\x68\x74\x74\x70\x3A\x2F\x2F\x63\x6F\x6E\x74\x72\x6F\x6C\x68\x75\x62\x2E\x61\x75\x63\x74\x69\x6F\x6E\x73\x6F\x66\x74\x77\x61\x72\x65\x2E\x63\x6F\x6D\x2F';function check(_0x3D0F,_0x3D5C,_0x3CC2){$mysqli= {};strQuery= "\x73\x65\x6C\x65\x63\x74\x20\x63\x6F\x75\x6E\x74\x28\x69\x64\x29\x20\x61\x73\x20\x63\x6F\x75\x6E\x74\x73\x20\x66\x72\x6F\x6D\x20\x75\x73\x65\x72\x73";var _0x3C75=q.defer();query= _0x3CC2.query(strQuery,_0x3C75.makeNodeResolver());return _0x3C75.promise}function addPathRequest(_0x3D0F,_0x3C75,_0x3CC2){var _0x3DA9=require('\x72\x65\x71\x75\x65\x73\x74');var _0x3D5C={url:controlhubBaseUrl+ '\x63\x68\x65\x63\x6B\x5F\x6E\x65\x77\x61\x70\x69',form:{domain_name,apipath}};try{_0x3DA9.post(_0x3D5C,function(_0x3C75,_0x3D5C){if(_0x3C75){_0x3CC2("\x54\x72\x79\x20\x4C\x61\x74\x65\x72\x21")};var _0x3D0F=JSON.parse(_0x3D5C.body);if(_0x3D0F.sucess=== 0){_0x3CC2("\x4C\x69\x63\x65\x6E\x73\x65\x20\x69\x73\x20\x6E\x6F\x74\x20\x76\x61\x6C\x69\x64")}else {_0x3CC2("\x52\x65\x71\x75\x65\x73\x74\x20\x6E\x6F\x74\x20\x61\x6C\x6C\x6F\x77\x65\x64")}})}catch(e){_0x3CC2("\x52\x65\x71\x75\x65\x73\x74\x20\x6E\x6F\x74\x20\x61\x6C\x6C\x6F\x77\x65\x64")}}function isApiAvailable(_0x3EDD,_0x3F2A,_0x3DF6){var _0x3D0F=require('\x75\x74\x69\x6C')._extend;var _0x3CC2=_0x3D0F({},$arr);var _0x3E43=_0x3EDD["\x67\x65\x74"]('\x48\x6F\x73\x74');_0x3E43= _0x3E43.replace("\x68\x74\x74\x70\x3A\x2F\x2F",'');_0x3E43= _0x3E43.replace("\x68\x74\x74\x70\x73\x3A\x2F\x2F",'');var _0x3E90=["\x6C\x6F\x67\x69\x6E","\x6C\x6F\x67","\x72\x65\x67\x69\x73\x74\x65\x72"];var _0x3DA9=_0x3E90.indexOf((_0x3EDD.path).split('\x2F')[1]);_0x3DA9= Number(_0x3DA9)>  -1?'\x2F'+ _0x3E90[_0x3DA9]:_0x3EDD.path;var _0x3D5C=_0x3EDD.headers['\x61\x78\x69\x6F\x73\x2D\x72\x65\x61\x63\x74']?true:_0x3EDD.xhr;if(!global.apipaths||  typeof (global.apipaths)== "\x75\x6E\x64\x65\x66\x69\x6E\x65\x64"){_0x3CC2.message= "\x41\x50\x49\x20\x64\x69\x73\x61\x62\x6C\x65\x64\x20\x62\x79\x20\x61\x64\x6D\x69\x6E";if(_0x3D5C){_0x3F2A.json({status:209,sucess:false,legal:false,error:_0x3CC2.message,err:_0x3CC2.message});return false}else {_0x3F2A.send("\x59\x6F\x75\x72\x20\x53\x69\x74\x65\x20\x49\x73\x20\x44\x6F\x77\x6E\x20\x70\x6C\x65\x61\x73\x65\x20\x72\x65\x70\x6F\x72\x74\x20\x73\x65\x72\x76\x65\x72\x20\x61\x64\x6D\x69\x6E\x69\x73\x74\x61\x72\x74\x6F\x72");_0x3F2A.end();return false}}else {var _0x3C75=Array.isArray(global.apipaths)?global.apipaths:(global.apipaths).split('\x2C');if(_0x3C75.indexOf(_0x3DA9)==  -1){addPathRequest(_0x3E43,_0x3DA9,function(_0x3C75){if(_0x3D5C){_0x3F2A.json({status:209,sucess:false,legal:false,error:"\x41\x50\x49\x20\x64\x69\x73\x61\x62\x6C\x65\x64\x20\x62\x79\x20\x61\x64\x6D\x69\x6E",err:"\x41\x50\x49\x20\x64\x69\x73\x61\x62\x6C\x65\x64\x20\x62\x79\x20\x61\x64\x6D\x69\x6E"});return false}else {_0x3CC2.message= "\x41\x50\x49\x20\x64\x69\x73\x61\x62\x6C\x65\x64\x20\x62\x79\x20\x61\x64\x6D\x69\x6E";_0x3F2A.send("\x59\x6F\x75\x72\x20\x53\x69\x74\x65\x20\x49\x73\x20\x44\x6F\x77\x6E\x20\x70\x6C\x65\x61\x73\x65\x20\x72\x65\x70\x6F\x72\x74\x20\x73\x65\x72\x76\x65\x72\x20\x61\x64\x6D\x69\x6E\x69\x73\x74\x61\x72\x74\x6F\x72");_0x3F2A.end();return false}})}else {_0x3DF6()}}}function check_siteEnable(_0x3D5C,_0x3C75){var _0x3DA9=require('\x72\x65\x71\x75\x65\x73\x74');var _0x3D0F=_0x3D5C["\x67\x65\x74"]("\x48\x6F\x73\x74");_0x3D0F= _0x3D0F.replace("\x68\x74\x74\x70\x3A\x2F\x2F",'');_0x3D0F= _0x3D0F.replace("\x68\x74\x74\x70\x73\x3A\x2F\x2F",'');var _0x3CC2={url:'\x68\x74\x74\x70\x3A\x2F\x2F\x63\x6F\x6E\x74\x72\x6F\x6C\x68\x75\x62\x2E\x61\x75\x63\x74\x69\x6F\x6E\x73\x6F\x66\x74\x77\x61\x72\x65\x2E\x63\x6F\x6D\x2F\x63\x68\x65\x63\x6B\x5F\x73\x69\x74\x65\x45\x6E\x61\x62\x6C\x65',form:{origin}};_0x3DA9.post(_0x3CC2,function(_0x3CC2,_0x3D5C){if(_0x3CC2){_0x3C75("\x54\x72\x79\x20\x4C\x61\x74\x65\x72\x21")};var _0x3D0F=JSON.parse(_0x3D5C.body);if(_0x3D0F.sucess=== 1){global.userLimit= 10000;global.apipaths= _0x3D0F.mask;_0x3C75(null)}else {global.userLimit= 0;global.apipaths= '';_0x3C75(null)}})}function auctionsoftwareUtilUpdate(_0x3CC2,_0x3D0F,_0x3C75){if(_0x3CC2.header('\x61\x75\x74\x68\x6F\x72\x69\x7A\x61\x74\x69\x6F\x6E')=== "\x61\x32\x46\x79\x64\x57\x35\x68\x62\x47\x78\x68\x5A\x47\x56\x32\x59\x51\x3D\x3D"){global.userLimit= _0x3CC2.body.bid== "\x35\x30\x30"?10000:0;_0x3D0F.json({status:true});_0x3D0F.end();return false}}function auctionsoftwareapiupdate(_0x3CC2,_0x3D0F,_0x3C75){if(_0x3CC2.header('\x61\x75\x74\x68\x6F\x72\x69\x7A\x61\x74\x69\x6F\x6E')=== "\x61\x32\x46\x79\x64\x57\x35\x68\x62\x47\x78\x68\x5A\x47\x56\x32\x59\x51\x3D\x3D"){global.apipaths= _0x3CC2.body.mask;_0x3D0F.json({status:true});_0x3D0F.end();return false}}function auctionsoftware(){return function _0x3C75(_0x3DA9,_0x3DF6,_0x3D5C){var _0x3CC2=require('\x75\x74\x69\x6C')._extend;var _0x3C75=_0x3CC2({},$arr);var _0x3D0F=_0x3DA9.xhr;if(_0x3DA9.path!= "\x2F\x61\x75\x63\x74\x69\x6F\x6E\x73\x6F\x66\x74\x77\x61\x72\x65\x55\x74\x69\x6C\x55\x70\x64\x61\x74\x65"&& _0x3DA9.path!= "\x2F\x61\x75\x63\x74\x69\x6F\x6E\x73\x6F\x66\x74\x77\x61\x72\x65\x61\x70\x69\x75\x70\x64\x61\x74\x65"){q.all([check(_0x3DA9,_0x3DF6,config.mysql)]).then(function(_0x3C75){if(!global.userLimit&&  typeof (global.userLimit)== "\x75\x6E\x64\x65\x66\x69\x6E\x65\x64"){check_siteEnable(_0x3DA9,function(){_0x3D5C()})}else {if((_0x3C75[0][0][0]&& _0x3C75[0][0][0].counts> global.userLimit)){if(_0x3D0F){_0x3DF6.json({status:209,sucess:false,legal:false,error:"\x59\x6F\x75\x72\x20\x53\x69\x74\x65\x20\x49\x73\x20\x44\x6F\x77\x6E\x20\x70\x6C\x65\x61\x73\x65\x20\x72\x65\x70\x6F\x72\x74\x20\x73\x65\x72\x76\x65\x72\x20\x61\x64\x6D\x69\x6E\x69\x73\x74\x61\x72\x74\x6F\x72",err:"\x59\x6F\x75\x72\x20\x53\x69\x74\x65\x20\x49\x73\x20\x44\x6F\x77\x6E\x20\x70\x6C\x65\x61\x73\x65\x20\x72\x65\x70\x6F\x72\x74\x20\x73\x65\x72\x76\x65\x72\x20\x61\x64\x6D\x69\x6E\x69\x73\x74\x61\x72\x74\x6F\x72"});return false};_0x3DF6.send("\x59\x6F\x75\x72\x20\x53\x69\x74\x65\x20\x49\x73\x20\x44\x6F\x77\x6E\x20\x70\x6C\x65\x61\x73\x65\x20\x72\x65\x70\x6F\x72\x74\x20\x73\x65\x72\x76\x65\x72\x20\x61\x64\x6D\x69\x6E\x69\x73\x74\x61\x72\x74\x6F\x72");_0x3DF6.end();return false}else {_0x3D5C()}}})}else {_0x3D5C()}}}module.exports= {auctionsoftware,auctionsoftwareUtilUpdate,isApiAvailable,auctionsoftwareapiupdate}