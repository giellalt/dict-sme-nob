<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:strip-space elements="*"/>
  <xsl:output method="text"
	      omit-xml-declaration="yes"
	      indent="no"/>
  
  <xsl:template match="r">
    <xsl:text>LEXICON Root</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
</xsl:text>
  </xsl:template>
  
  <xsl:template match="e">
    <xsl:text>
</xsl:text>
<xsl:value-of select="lg/l"/>:<xsl:value-of select="replace(mg[1]/tg[1]/t[1],' ', '_')"/>
    <xsl:text> # ;</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>

