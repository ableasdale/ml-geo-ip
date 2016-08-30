xquery version "1.0-ml";

declare namespace dir = "http://marklogic.com/xdmp/directory";
import module namespace lib-view = "http://help.marklogic.com/lib-view" at "lib/lib-view.xqy";

(:~
: User: ableasdale
: Date: 29/08/2016
: Time: 20:53
: To change this template use File | Settings | File Templates.
:)

lib-view:create-bootstrap-page(
    "title",
    element div {attribute class {"container"},
        element h3 {"Links"},
        element ul {
            for $i in xdmp:filesystem-directory(xdmp:modules-root())/dir:entry/dir:filename
            where fn:ends-with($i, ".xqy") and fn:not(fn:contains($i, "default.xqy"))
            return element li {element a {attribute href {"/"||$i}, xs:string($i)}}
        }
    }
)