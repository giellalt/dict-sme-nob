xquery version "1.0";

declare namespace saxon="http://saxon.sf.net/";

declare option saxon:output "method=text";
declare option saxon:output "encoding=UTF-8";

(:
    | 
    | NB: One needs a SAXON xml processor
    | The input: the smenob.xml dictionary file
    | Usage: java net.sf.saxon.Query smenob-pairs.xql smenob.xml
    | 
:)

declare variable $smenob external;

<r>LEXICON Root
{
for $element in doc($smenob)//e
let $nl := "&#xa;"
let $l := replace(normalize-space($element/lg/l), " ", "% ")
let $t := replace(normalize-space($element/mg[1]/tg[1]/*[starts-with(local-name(), 't')][1])," ","_")
return <e>{concat($l, ":", $t, " # ;", $nl)}</e>
} </r>
