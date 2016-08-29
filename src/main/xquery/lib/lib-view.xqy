xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 29/08/2016
: Time: 20:57
: To change this template use File | Settings | File Templates.
:)

module namespace lib-view = "http://help.marklogic.com/lib-view";

declare function lib-view:get-freegeoip-info($ip as xs:string) {
    element pre {element code{xdmp:document-get("http://freegeoip.net/xml/"||$ip)}}
};

declare function lib-view:wipmania-ip($ip as xs:string) {
    element pre {element code{xdmp:document-get("http://api.wipmania.com/"||$ip)}}
};

declare function lib-view:gmaps-link($item) {
(:"http://maps.google.com/?q="||$item//latitude||","||$item//longitude :)
    "http://maps.googleapis.com/maps/api/staticmap?center="||$item//latitude||","||$item//longitude||"&amp;zoom=13&amp;size=450x300&amp;key=AIzaSyDLmp1mfNAgUMnFnFOrHQlNAmGSJmmqScI"
};

declare function lib-view:create-flag-link($item as xs:string) {
    element img {attribute src {"/assets/images/flags/"||$item||".png"}}
};

declare function lib-view:create-bootstrap-page($title as xs:string, $content as element(div)) {
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