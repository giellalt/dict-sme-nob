<?xml version="1.0"?>
<!--+
    | Transforms termcenter.xml files into tab-separated entries of sme-nob.
    | Usage: xsltproc termc2txt.xsl termcenter.xml
    | 
    +-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">

<xsl:output method="xml"
            encoding="UTF-8"/>

 <xsl:param name="gtpath">../../../../gt/sme/testing</xsl:param>

<xsl:template match="lg">
 <xsl:param name="document" select="concat(
            'file:',
             $gtpath,
            '/',
             l,
            '.xml')"/>
  <lg>
   <xsl:apply-templates/>
   <xsl:copy-of select="document($document)"/>
  </lg>
</xsl:template>

  <xsl:template match="node()|@*" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
