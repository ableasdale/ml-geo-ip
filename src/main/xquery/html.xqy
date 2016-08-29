xquery version "1.0-ml";

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";
import module namespace lib-view = "http://help.marklogic.com/lib-view" at "lib/lib-view.xqy";

declare variable $IPv4 as xs:string+ := ("43.230.176.243", "212.58.246.93", "139.130.4.5", "54.240.195.68", "74.125.224.72",
"151.111.166.96", "170.149.161.130", "54.240.254.230", "78.41.128.140", "62.138.116.25", "54.239.54.107", "95.130.42.33",
"147.67.119.103", "205.193.215.159", "31.192.231.167", "195.66.10.19", "193.146.141.234", "54.239.38.117", "54.239.96.90",
"177.72.244.194", "52.95.193.28", "54.240.226.81", "52.95.80.34", "194.150.245.142", "12.48.40.0", "194.213.125.0", "164.100.78.177",
"93.210.15.68", "146.192.201.18", "213.174.72.92", "146.198.178.59", "161.148.175.40", "197.149.176.23", "131.207.14.37",
"88.255.55.110", "186.33.211.142", "41.204.167.86", "95.173.136.70", "103.28.250.187", "103.8.161.146", "84.205.254.125"
);

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


lib-view:create-bootstrap-page(
    "title",
    element div {attribute class {"container"},
        for $i in $IPv4
        let $match := local:nearest-match(local:find-matching-ip-data($i), $i)
        let $country := local:get-country-geoname-id($match//registered_country_geoname_id)
        let $city := local:get-geoname-id($match//geoname_id)

        return
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">{$i}</h3>
                </div>
                <div class="panel-body">{
                    element textarea {lib-view:gmaps-link($match)},
                    element img {attribute width {"450"}, attribute src {lib-view:gmaps-link($match)}},
                    lib-view:create-flag-link(fn:lower-case(xs:string($country//country_iso_code))),
                    element pre {element code{$match}},
                    element pre {element code{$country}},
                    element pre {element code{$city}},
                    lib-view:get-freegeoip-info($i),
                    lib-view:wipmania-ip($i)
                }</div>
            </div>
    }
)