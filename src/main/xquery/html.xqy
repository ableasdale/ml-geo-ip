xquery version "1.0-ml";

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";

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

declare function local:gmaps-link($item) {
(:"http://maps.google.com/?q="||$item//latitude||","||$item//longitude :)
    "http://maps.googleapis.com/maps/api/staticmap?center="||$item//latitude||","||$item//longitude||"&amp;zoom=13&amp;size=450x300&amp;key=AIzaSyDLmp1mfNAgUMnFnFOrHQlNAmGSJmmqScI"
};

declare function local:create-flag-link($item as xs:string) {
    element img {attribute src {"/assets/images/flags/"||$item||".png"}}
};

declare function local:get-geoname-id($item as xs:string) {
    cts:search((//GeoLite2-City-Locations-en), cts:element-value-query(xs:QName("geoname_id"), $item))
};

declare function local:get-country-geoname-id($item as xs:string) {
    cts:search( (//GeoLite2-Country-Locations-en), cts:element-value-query(xs:QName("geoname_id"), $item))
};

declare function local:get-freegeoip-info($ip as xs:string) {
    element pre {element code{xdmp:document-get("http://freegeoip.net/xml/"||$ip)}}
};

declare function local:wipmania-ip($ip as xs:string) {
    element pre {element code{xdmp:document-get("http://api.wipmania.com/"||$ip)}}
};

(:
xs:string(functx:substring-before-last(functx:substring-before-last($IPv4, '.'),'.')||"*"),
xs:string(functx:substring-before-last($IPv4, '.')||"*") :)

(:
local:gmaps-link(local:nearest-match(local:find-matching-ip-data($IPv4))) :)
(: xdmp:set-response-content-type("text/html"), xdmp:set-response-encoding("utf-8"),:)

declare function local:create-bootstrap-page($title as xs:string, $content as element(div)) {
    xdmp:log("Creating page: "|| $title),
    xdmp:set-response-content-type("text/html; charset=utf-8"),
    '<!DOCTYPE html>',
    element html {attribute lang {"en"},
    element head {
        element meta {attribute charset {"utf-8"}},
        element meta {attribute http-equiv {"X-UA-Compatible"}, attribute content {"IE=edge"}},
        element meta {attribute name {"viewport"}, attribute content {"width=device-width, initial-scale=1"}},
        element title {$title},
        element link {
            attribute rel {"stylesheet"},
            attribute href {"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"},
            attribute integrity {"sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"},
            attribute crossorigin {"anonymous"}
        },
        element link {
            attribute rel {"stylesheet"},
            attribute href {"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"},
            attribute integrity {"sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"},
            attribute crossorigin {"anonymous"}
        },
        element link {
            attribute rel {"stylesheet"},
            attribute href {"https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.11.0/codemirror.min.css"}
        },
        element link {
            attribute rel {"stylesheet"},
            attribute href {"/assets/css/styles.css"}
        }
    },
    element body { $content }
    },
    <script src="https://code.jquery.com/jquery-2.2.1.min.js">{" "}</script>,
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous">{" "}</script>
};

local:create-bootstrap-page(
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
                    element textarea {local:gmaps-link($match)},
                    element img {attribute width {"450"}, attribute src {local:gmaps-link($match)}},
                    local:create-flag-link(fn:lower-case(xs:string($country//country_iso_code))),
                    element pre {element code{$match}},
                    element pre {element code{$country}},
                    element pre {element code{$city}},
                    local:get-freegeoip-info($i),
                    local:wipmania-ip($i)
                }</div>
            </div>
    }
)