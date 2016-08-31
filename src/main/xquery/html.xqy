xquery version "1.0-ml";

import module namespace functx = "http://www.functx.com" at "/MarkLogic/functx/functx-1.0-nodoc-2007-01.xqy";
import module namespace lib-view = "http://help.marklogic.com/lib-view" at "lib/lib-view.xqy";
import module namespace lib-geosearch = "http://help.marklogic.com/lib-geosearch" at "lib/lib-geosearch.xqy";
import module namespace lib-testdata = "http://help.marklogic.com/lib-testdata" at "lib/lib-testdata.xqy";

(: declare variable $SEARCH-IP as xs:string := functx:substring-before-last($IPv4, '.'); :)

lib-view:create-bootstrap-page(
    "title",
    element div {attribute class {"container"},
        for $i in lib-testdata:get-company-ip-list()
        let $match := lib-geosearch:nearest-match(lib-geosearch:find-matching-ip-data($i), $i)
        let $country := lib-geosearch:get-country-geoname-id($match//registered_country_geoname_id)
        let $city := lib-geosearch:get-geoname-id($match//geoname_id)

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