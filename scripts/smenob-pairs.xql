xquery version "1.0";

declare namespace saxon="http://saxon.sf.net/";

declare option saxon:output "method=text";
declare option saxon:output "encoding=UTF-8";
declare option saxon:output "strip-space=yes"; 
declare option saxon:output "ignore-whitespace=true";

(:
    | 
    | NB: One needs the latest version of the SAXON!
    | The input: the smenob.xml dictionary file
    | Usage: java net.sf.saxon.Query smenob-pairs.xql smenob.xml
    | 
:)

declare variable $smenob external;

<r>LEXICON Root
{
for $element in doc($smenob)//e
let $t := $element/replace(normalize-space(mg[1]/tg[1]/t[1])," ","_")
return <e>{concat($element/lg/l, ":", $t, " # ;", "
")}</e>
} </r>
