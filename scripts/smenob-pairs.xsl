<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>

<xsl:template match="r">
LEXICON Root
    <xsl:apply-templates>
</xsl:template>

<!-- For Ciprian to have xslt 2.0 fun from here on - add replace function -->
<xsl:template match="e">
    <xsl:value-of select="lg/l"/>:<xsl:value-of select="replace(mg/tg/t[1],' ', '_')"/> ;

</xsl:template>

</xsl:stylesheet>
