# ml-geo-ip
MarkLogic Geo IP Location search code

Current plan is to load data from 5 _freely_ available databases and to search across all 5 to get the most accurate results possible from an IP address to geolocation search.

These dbs are:
- http://software77.net/geo-ip/
- http://www.ipligence.com/free-ip-database
- https://db-ip.com/db
- https://dev.maxmind.com/geoip/geoip2/geolite2/
- http://lite.ip2location.com


## TODO - Data Setup (see my csv-loader project to load the data..)


http://geoip.nekudo.com/api/194.150.245.142
https://lite.ip2location.com/faqs

TODO: load this in...
view-source:http://www.nirsoft.net/countryip/
http://www.nirsoft.net/countryip/de.html
http://www.ipligence.com/free-ip-database
http://software77.net/geo-ip/

http://api.geoiplookup.net/?query=146.198.178.59
http://geoip.nekudo.com/api/197.149.176.23/en/full

Add VFS support for CSV loading!

## TODO - Database index settings

Using wildcarded searches to try to improve accuracy from the basic dataset; index settings are documented at:
https://docs.marklogic.com/guide/search-dev/wildcard#id_14163

Currently reviewing alternatives to figure out best index settings for this data...


### Setup Notes
```xquery
xquery version "1.0-ml";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy";

declare variable $DATABASE as xs:string := "GeoIP";
declare variable $PORT as xs:unsignedLong := 8086;
declare variable $PATH := "/ROOT/PATH/TO/ml-geo-ip/src/main/xquery";

declare function local:create-http-application-server() {
  let $config := admin:get-configuration()
  let $config := admin:http-server-create($config, admin:group-get-id($config, "Default"), fn:concat("http-",$PORT),
        $PATH, $PORT, 0, xdmp:database($DATABASE))
(:  let $config := admin:appserver-set-authentication($config,
         admin:appserver-get-id($config, admin:group-get-id($config, "Default"), fn:concat("http-",$PORT)),
         "application-level") :)
  return
  admin:save-configuration($config)
};

local:create-http-application-server()
```

## Attribution

This site or product includes IP2Location LITE data available from <a href="http://lite.ip2location.com">http://lite.ip2location.com</a>.

This product includes GeoLite2 data created by MaxMind, available from <a href="http://www.maxmind.com">http://www.maxmind.com</a>.

This product includes DB IP data, available from  https://db-ip.com/db/download/city and https://db-ip.com/db/download/country

Flag icons from famfamfam: http://www.famfamfam.com/lab/icons/flags/ 

Schema objects from: http://www.codesynthesis.com/projects/xsstl/