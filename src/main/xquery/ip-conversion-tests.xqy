xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 31/08/2016
: Time: 09:13
: To change this template use File | Settings | File Templates.
:)

import module namespace lib-ip = "http://help.marklogic.com/lib-ip" at "lib/lib-ip.xqy";
import module namespace lib-testdata = "http://help.marklogic.com/lib-testdata" at "lib/lib-testdata.xqy";
import module namespace lib-view = "http://help.marklogic.com/lib-view" at "lib/lib-view.xqy";
(: import module namespace additional-testdata = "http://help.marklogic.com/additional-testdata" at "lib/additional-testdata.xqy"; :)

lib-view:create-bootstrap-page(
        "IP / IPN Conversion Tests",
        <div class="container">
            <h3>IP / IPN Conversion <small>Code Tests</small></h3>
            <table class="table table-striped table-bordered table-condensed">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Orig. IP</th>
                        <th>IPN</th>
                        <th>Length (hex)</th>
                        <th>IPN to IP</th>
                        <th>Same?</th>
                    </tr>
                </thead>
                <tbody>
                    {
                        for $i at $pos in lib-testdata:get-large-testset() (: additional-testdata:stupidly-long-ip-list() :)
                        return
                            element tr {
                                element td {$pos},
                                element td {$i},
                                element td {lib-ip:convert-ip-to-integer($i)},
                                element td {fn:string-length(xdmp:integer-to-hex(lib-ip:convert-ip-to-integer($i)))},
                                element td {lib-ip:convert-integer-to-ip(lib-ip:convert-ip-to-integer($i))},
                                element td {

                                    if ($i eq lib-ip:convert-integer-to-ip(lib-ip:convert-ip-to-integer($i)))
                                    then (attribute class {"success"}, "Yes")
                                    else (attribute class {"danger"}, "No")
                                }

                            }
                    }
                </tbody>
            </table>
        </div>)
