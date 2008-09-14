xquery version "1.0";

declare namespace saxon="http://saxon.sf.net/";

declare option saxon:output "method=text";
declare option saxon:output "encoding=UTF-8";
declare option saxon:output "strip-space=yes"; 
declare option saxon:output "ignore-whitespace=true";

(:
    | 
    | The input: may be either paths to the files to merge or to the whole directory
    | Usage: xxx collect-smenob-parts.xql
    | 
:)

declare variable $smenob external;

<r>LEXICON Root
{
for $element in doc($smenob)//e
let $t := $element/replace(normalize-space(mg[1]/tg[1]/t[1])," ","_")
return <e>{$element/lg/l, 
  <f>:</f>, 
  <g>{$t}</g>,
  <g> # ;</g>, "
"}</e>
} </r>
