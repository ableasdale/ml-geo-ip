xquery version "1.0-ml";

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";
import module namespace lib-view = "http://help.marklogic.com/lib-view" at "lib/lib-view.xqy";

declare variable $IPv4 as xs:string+ := ("43.230.176.243", "212.58.246.93", "139.130.4.5", "54.240.195.68", "74.125.224.72",
"151.111.166.96", "170.149.161.130", "54.240.254.230", "78.41.128.140", "62.138.116.25", "54.239.54.107", "95.130.42.33",
"147.67.119.103", "205.193.215.159", "31.192.231.167", "195.66.10.19", "193.146.141.234", "54.239.38.117", "54.239.96.90",
"177.72.244.194", "52.95.193.28", "54.240.226.81", "52.95.80.34", "194.150.245.142");

declare variable $SEARCH-IP as xs:string := functx:substring-before-last($IPv4, '.');

declare function local:find-matching-ip-data($ipaddr as xs:string) as item()* {
    let $candidates :=
        (: First try searching for three segments [xxx.xxx.xxx.*] :)
        if (count(cts:search(doc(), cts:element-value-query(xs:QName("network"), xs:string(functx:substring-before-last($ipaddr, '.')||"*"), "wildcarded"))) eq 0)
        (: If there are no matches, try the just the first two segments [xxx.xxx.*] :)
        then (cts:search(doc(), cts:element-value-query(xs:QName("network"), xs:string(functx:substring-before-last(functx:substring-before-last($ipaddr, '.'),'.')||"*"), "wildcarded")))
        else (cts:search(doc(), cts:element-value-query(xs:QName("network"), xs:string(functx:substring-before-last($ipaddr, '.')||"*"), "wildcarded")))
    (: get all matches and get the most frequent geoname id :)
    let $sequence := $candidates/GeoLite2-City-Blocks-IPv4/geoname_id
    let $highest-match := for $maxFreq in max(for $val in distinct-values($sequence) return count(index-of($sequence, $val))) return distinct-values($sequence)[count(index-of($sequence, .)) eq $maxFreq]
    return $candidates[//geoname_id/. eq $highest-match]
};

declare function local:nearest-match($items as item()*, $i as xs:string?) {
    fn:root(($items//accuracy_radius[. eq min($items//accuracy_radius) ])[1])
(: for $item in $items
   where some $item in $items satisfies min($item//accuracy_radius)
   return $item :)

};

declare function local:get-geoname-id($item as xs:string) {
    cts:search((//GeoLite2-City-Locations-en), cts:element-value-query(xs:QName("geoname_id"), $item))
};

declare function local:get-country-geoname-id($item as xs:string) {
    cts:search( (//GeoLite2-Country-Locations-en), cts:element-value-query(xs:QName("geoname_id"), $item))
};

xdmp:set-response-content-type("application/xml"),
xdmp:set-response-encoding("utf-8"),
element data {
    for $i in $IPv4
    let $match := local:nearest-match(local:find-matching-ip-data($i), $i)
    let $country := local:get-country-geoname-id($match//registered_country_geoname_id)
    let $city := local:get-geoname-id($match//geoname_id)
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
