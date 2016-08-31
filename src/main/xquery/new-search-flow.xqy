xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 30/08/2016
: Time: 21:30
: To change this template use File | Settings | File Templates.
:)

import module namespace lib-ip = "http://help.marklogic.com/lib-ip" at "lib/lib-ip.xqy";
import module namespace lib-geosearch = "http://help.marklogic.com/lib-geosearch" at "lib/lib-geosearch.xqy";
import module namespace lib-testdata = "http://help.marklogic.com/lib-testdata" at "lib/lib-testdata.xqy";

xdmp:set-response-content-type("application/xml"),
xdmp:set-response-encoding("utf-8"),
element data {
    for $i in lib-testdata:get-aws-ip-list()
    return element Location {
        attribute ip {$i},
        attribute ipn {lib-ip:convert-ip-to-integer($i)},
        lib-geosearch:find-ipns-in-range(lib-ip:convert-ip-to-integer($i))
    }
}