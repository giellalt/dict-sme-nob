<?xml version="1.0"?>
<!--+
    | Transforms termcenter.xml files into tab-separated entries of sme-nob.
    | Usage: xsltproc termc2txt.xsl termcenter.xml
    | 
    +-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  version="1.0">

  <xsl:output method="text"/>

  <xsl:template match="termCenter">
    <xsl:apply-templates />
   </xsl:template>

  <xsl:template match="entry[not(contains(entryref[@xml:lang = 'sme']/xi:include/@href,'_'))]
  [entryref/@xml:lang = 'sme']
  [entryref/@xml:lang = 'nor']
  ">
    <!-- sme string: -->
    <xsl:param name="smestring" select="entryref[@xml:lang = 'sme']/xi:include/@href"/>
    <!-- nob string: -->
    <xsl:param name="nobstring" select="entryref[@xml:lang = 'nor']/xi:include/@href"/>
    <!-- sme lemma: -->
    <xsl:param name="sme" select="substring(substring-after(substring-before($smestring,'\'),'[@id='),2)"/>
    <!-- sme pos: -->
    <xsl:param name="smepos" select="substring(substring-after(substring-before($smestring,']'),'\'),1,1)"/>
    <!-- nob lemma: -->
    <xsl:param name="nob" select="substring(substring-after(substring-before($nobstring,'\'),'[@id='),2)"/>
    <!-- nob pos: -->
    <xsl:param name="nobpos" select="substring(substring-after(substring-before($nobstring,']'),'\'),1,1)"/>
    <xsl:value-of select="$sme"/>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="$smepos"/>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="$nob"/>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="$nobpos"/>
    <xsl:text>
</xsl:text>
   </xsl:template>

</xsl:stylesheet>