xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 31/08/2016
: Time: 09:13
: To change this template use File | Settings | File Templates.
:)

import module namespace lib-ip = "http://help.marklogic.com/lib-ip" at "lib/lib-ip.xqy";
import module namespace lib-testdata = "http://help.marklogic.com/lib-testdata" at "lib/lib-testdata.xqy";


for $i in lib-testdata:get-pingdom-ip-list()
return
    text {$i, "&#9;", lib-ip:convert-ip-to-integer($i), "&#9;", fn:string-length(xdmp:integer-to-hex(lib-ip:convert-ip-to-integer($i))), "&#9;",lib-ip:convert-integer-to-ip(lib-ip:convert-ip-to-integer($i)), "&#9;&#9;", ($i eq lib-ip:convert-integer-to-ip(lib-ip:convert-ip-to-integer($i)))}

