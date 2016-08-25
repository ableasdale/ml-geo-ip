xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 25/08/2016
: Time: 22:03
:)

import module namespace lib-ip = "http://help.marklogic.com/lib-ip" at "lib/lib-ip.xqy";
import module namespace lib-geosearch = "http://help.marklogic.com/lib-geosearch" at "lib/lib-geosearch.xqy";

xdmp:set-response-content-type("application/xml"),
xdmp:set-response-encoding("utf-8"),
element data {
    lib-geosearch:find-ipns-in-range(lib-ip:convert-ip-to-integer("160.109.104.44"))
}