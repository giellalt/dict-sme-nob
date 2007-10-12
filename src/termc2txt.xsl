<?xml version="1.0" encoding="UTF-8"?>
<!--+
    | Transforms termcenter.xml files into tab-separated entries of sme-nob.
    | Usage: xsltproc termc2txt.xsl termcenter.xml
    | 
    +-->

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  exclude-result-prefixes="xi"
  version="1.0">

  <xsl:output method="xml" indent="yes"/>
  <xsl:output encoding="UTF-8"/>
  <xsl:output omit-xml-declaration="yes"/>

  <xsl:template match="termCenter">
   <r>
    <xsl:apply-templates />
   </r>
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
    <xsl:param name="smepos" select="substring(substring-after(substring-before($smestring,']'),'\'),
    										  1,
    										  string-length(substring-after(substring-before($smestring,']'),'\'))-1)"/>
    <xsl:param name="smeposclean">
      <xsl:choose>
        <xsl:when test="$smepos = 'S'">n</xsl:when>
        <xsl:when test="$smepos = 'A'">a</xsl:when>
        <xsl:when test="$smepos = 'V'">v</xsl:when>
        <xsl:when test="$smepos = 'Adv'">adv</xsl:when>
        <xsl:when test="$smepos = 'PP'">po</xsl:when>
        <xsl:when test="$smepos = 'Pron'">pron</xsl:when>
      </xsl:choose>
    </xsl:param>
    <!-- nob lemma: -->
    <xsl:param name="nob" select="translate(substring(substring-after(substring-before($nobstring,'\'),'[@id='),2),'_',' ')"/>
    <!-- nob pos: -->
    <xsl:param name="nobpos" select="substring(substring-after(substring-before($nobstring,']'),'\'),
    										  1,
    										  string-length(substring-after(substring-before($nobstring,']'),'\'))-1)"/>
    <xsl:param name="nobposclean">
      <xsl:choose>
        <xsl:when test="$nobpos = 'S'">S</xsl:when>
        <xsl:when test="$nobpos = 'A'">a</xsl:when>
        <xsl:when test="$nobpos = 'V'">v</xsl:when>
        <xsl:when test="$nobpos = 'Adv'">adv</xsl:when>
        <xsl:when test="$nobpos = 'PP'">p</xsl:when>
        <xsl:when test="$nobpos = 'Pron'">pron</xsl:when>
      </xsl:choose>
    </xsl:param>
    <!--xsl:value-of select="$sme"/>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="$smepos"/>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="$nob"/>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="$nobpos"/>
    <xsl:text>
</xsl:text-->
    <e><lg><l pos="{$smeposclean}"><xsl:value-of select="$sme"/></l></lg><mg><tg><t pos="{$nobposclean}"><xsl:value-of select="$nob"/></t></tg></mg></e>
  </xsl:template>

</xsl:stylesheet>


<!--
l pos="S"/l pos="n"
"A"/"a"
"Adv"/"adv"
"V"/"v"
"PP"/"po"
"Pron"/"pron"

smenob:
 a  = Adjective
 m  = Masculine (nob)
 f  = Feminine (nob) 
 n  = Neuter (nob), noun (sme)
 S  = noun, still not given gender (nob)
 v  = verb

risten
A
Adv
PP
Pron
S
V

-->