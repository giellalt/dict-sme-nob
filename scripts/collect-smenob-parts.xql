xquery version "1.0";

declare namespace saxon="http://saxon.sf.net/";

declare option saxon:output "doctype-public=-//XMLmind//DTD smenob//SE";
declare option saxon:output "doctype-system=../scripts/smenob.dtd";
declare option saxon:output "method=xml";
declare option saxon:output "encoding=UTF-8";
declare option saxon:output "omit-xml-declaration=no"; 
declare option saxon:output "indent=yes"; 
declare option saxon:output "saxon:indent-spaces=3"; 


(:
    | 
    | The input: may be either paths to the files to merge or to the whole directory
    | Usage: xxx collect-smenob-parts.xql
    | 
:)

declare variable $adj external;
declare variable $adv external;
declare variable $nounc external;
declare variable $nounp external;
declare variable $other external;
declare variable $verb external;

<?xml-stylesheet type="text/css" href="../scripts/smenob.css"?>,'
',
<?xml-stylesheet type="text/xsl" href="../scripts/smenob.xsl"?>,'
',
<r> {
  for $element in (doc($adj)//e, doc($adv)//e, doc($nounc)//e, doc($nounp)//e, doc($other)//e, doc($verb)//e)
  return   $element 
} </r>, '
'
