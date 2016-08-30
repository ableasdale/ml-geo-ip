xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 25/08/2016
: Time: 10:33
:)

module namespace lib-geosearch = "http://help.marklogic.com/lib-geosearch";

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";

declare function lib-geosearch:find-ipns-in-range($ipn as xs:integer) as item()* {
    cts:search(fn:doc(),
            cts:and-query((
                cts:element-range-query(xs:QName("IP-From"), "<=", $ipn),
                cts:element-range-query(xs:QName("IP-TO"), ">=", $ipn)
            ))
    )
};

declare function lib-geosearch:find-location-by-geoname-id($id as xs:integer) as item()* {
    cts:search((//GeoLite2-City-Locations-en), cts:element-value-query(xs:QName("geoname_id"), ($id)))
};

declare function lib-geosearch:get-geoname-id($item as xs:string) as item()* {
    cts:search((//GeoLite2-City-Locations-en), cts:element-value-query(xs:QName("geoname_id"), $item))
};

declare function lib-geosearch:get-country-geoname-id($item as xs:string) as item()* {
    cts:search((//GeoLite2-Country-Locations-en), cts:element-value-query(xs:QName("geoname_id"), $item))
};

(: TODO - this is really inaccurate - redo it but balance it with ipns and take the most common :)
declare function lib-geosearch:find-matching-ip-data($ipaddr as xs:string) as item()* {
    let $candidates :=
        (: First try searching for three segments [xxx.xxx.xxx.*] :)
        if (count(cts:search(fn:doc(), cts:element-value-query(xs:QName("network"), xs:string(functx:substring-before-last($ipaddr, '.') || "*"), "wildcarded"))) eq 0)
        (: If there are no matches, try the just the first two segments [xxx.xxx.*] :)
        then (cts:search(fn:doc(), cts:element-value-query(xs:QName("network"), xs:string(functx:substring-before-last(functx:substring-before-last($ipaddr, '.'), '.') || "*"), "wildcarded")))
        else (cts:search(fn:doc(), cts:element-value-query(xs:QName("network"), xs:string(functx:substring-before-last($ipaddr, '.') || "*"), "wildcarded")))
    (: get all matches and get the most frequent geoname id :)
    let $sequence := $candidates/GeoLite2-City-Blocks-IPv4/geoname_id
    let $highest-match := for $maxFreq in fn:max(for $val in fn:distinct-values($sequence) return fn:count(fn:index-of($sequence, $val))) return fn:distinct-values($sequence)[fn:count(fn:index-of($sequence, .)) eq $maxFreq]
    return $candidates[//geoname_id/. eq $highest-match]
};

declare function lib-geosearch:nearest-match($items as item()*, $i as xs:string?) {
    fn:root(($items//accuracy_radius[. eq fn:min($items//accuracy_radius)])[1])
(: for $item in $items
   where some $item in $items satisfies min($item//accuracy_radius)
   return $item :)
};


