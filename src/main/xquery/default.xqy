xquery version "1.0-ml";

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
        element ul {
            element li {element a {attribute href {"html.xqy"}, "html.xqy"}},
            element li {element a {attribute href {"search.xqy"}, "search.xqy"}},
            element li {element a {attribute href {"xml.xqy"}, "xml.xqy"}}
        }
    }
)