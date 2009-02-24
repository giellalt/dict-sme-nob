<?xml version="1.0"?>
<!--+
    | 
    | The parameter: the path to the collection of XML-files to compile
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main collect-dict-parts.xsl dir=DIR
    | java -Xmx2048m net.sf.saxon.Transform -it main find_double_genSg_forms.xsl dir=/Users/cipriangerstenberger/gtsvn/gt/sme/testing/Parafiles/LastBackUp_gen-paradigm/Gen_tmp/XML_out
    | 
    +-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      doctype-system="../../scripts/gt_dictionary.dtd"
	      doctype-public="-//XMLmind//DTD gt_dictionary//SE"
	      indent="yes"/>
  
  <xsl:param name="dir" select="'.'"/>

  <xsl:template match="/" name="main">

    <!-- parametrize href values! -->

    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>type="text/css" href="../../scripts/gt_dictionary.css"</xsl:text>
    </xsl:processing-instruction>
    
    <xsl:text>
</xsl:text>

    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>type="text/xsl" href="../../scripts/gt_dictionary.xsl"</xsl:text>
    </xsl:processing-instruction>

    <!-- why does that '&#xa;' not function? -->
    <xsl:text>
</xsl:text>

<!-- collection('PATH?recurse=yes;select=*.xml') -->
<!-- collection('PATH?select=*.xml') -->

    <r>
      
      <!--       <xsl:copy-of select="collection(concat($dir, '?select=*_n.xml'))/result/e/lg/l[(../analysis='Sg_Nom') and (../../../mini_paradigm/analysis[@ms='Sg_Gen' and (count(distinct-values(./wordform)) &gt; 1)])] "/> -->
      <!--       <xsl:copy-of select="collection(concat($dir, '?select=*_n.xml'))/result/mini_paradigm/analysis[@ms='Sg_Gen' and (count(distinct-values(./wordform)) &gt; 1)] "/> -->
      
      <xsl:for-each select="collection(concat($dir, '?select=*_n.xml'))/result[./e/lg/l[(../analysis='Sg_Nom') and (../../../mini_paradigm/analysis[@ms='Sg_Gen' and (count(distinct-values(./wordform)) &gt; 1)])]]">
	<e>
	  <xsl:copy-of select="./e/lg/l[../analysis='Sg_Nom']"/>
	  <xsl:copy-of select="./mini_paradigm/analysis[@ms='Sg_Gen']"/>
	</e>
      </xsl:for-each>

    </r>
  </xsl:template>
  
</xsl:stylesheet>
