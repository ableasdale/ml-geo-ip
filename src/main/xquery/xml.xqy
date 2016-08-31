xquery version "1.0-ml";

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";
import module namespace lib-view = "http://help.marklogic.com/lib-view" at "lib/lib-view.xqy";
import module namespace lib-geosearch = "http://help.marklogic.com/lib-geosearch" at "lib/lib-geosearch.xqy";
import module namespace lib-testdata = "http://help.marklogic.com/lib-testdata" at "lib/lib-testdata.xqy";

(:declare variable $SEARCH-IP as xs:string := functx:substring-before-last($IPv4, '.'); :)

xdmp:set-response-content-type("application/xml"),
xdmp:set-response-encoding("utf-8"),
element data {
    for $i in lib-testdata:get-aws-ip-list()
    let $match := lib-geosearch:nearest-match(lib-geosearch:find-matching-ip-data($i), $i)
    let $country := lib-geosearch:get-country-geoname-id($match//registered_country_geoname_id)
    let $city := lib-geosearch:get-geoname-id($match//geoname_id)
    return (
        element content {
            element ip {$i},
            element gmaps {lib-view:gmaps-link($match)},
            element flag {lib-view:create-flag-link(fn:lower-case(xs:string($country//country_iso_code)))},
            $match,
            $country,
            $city
        }
    )
}

(:
let $ipmatch := local:nearest-match(local:find-matching-ip-data($IPv4[1]), $IPv4[1])
return ($ipmatch, local:get-country-geoname-id($ipmatch//registered_country_geoname_id), local:get-geoname-id($ipmatch//geoname_id))
:)
