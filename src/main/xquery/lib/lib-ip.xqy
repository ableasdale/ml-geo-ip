xquery version "1.0-ml";

(:~
: User: ableasdale
: Date: 21/08/2016
: Time: 10:20
: To change this template use File | Settings | File Templates.
:)

module namespace lib-ip = "lib-ip";

declare function lib-ip:convert-ip-to-integer($ip as xs:string) as xs:integer {
(: TODO - IP v4 is a predictable datatype - XML Schema for this as a simple type? :)
    let $i := fn:reverse(fn:tokenize($ip, "\."))
    return xs:integer($i[1]) + xs:integer($i[2]) * 256 + xs:integer($i[3]) * 256 * 256 + xs:integer($i[4]) * 256 * 256 * 256
};

declare function lib-ip:convert-integer-to-ip($int as xs:integer) as xs:string {
(: if the hex representation is 7 characters (rather than 8), place a '0' in front to ensure the IP resolution is correct :)
    let $i := if (fn:string-length(xdmp:integer-to-hex($int)) eq 7)
    then ("0" || xdmp:integer-to-hex($int))
    else (xdmp:integer-to-hex($int))
    return
        fn:string-join(
            (
                xs:string(xdmp:hex-to-integer(fn:substring($i, 1, 2))),
                xs:string(xdmp:hex-to-integer(fn:substring($i, 3, 2))),
                xs:string(xdmp:hex-to-integer(fn:substring($i, 5, 2))),
                xs:string(xdmp:hex-to-integer(fn:substring($i, 7, 2)))
            ), "."
        )
};