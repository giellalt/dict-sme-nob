<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="*">
    <r>
    <xsl:copy-of select="document(../src/adjective_smenob.xml)/r/e">
    <xsl:copy-of select="document(../src/adverb_smenob.xml)/r/e">
    <xsl:copy-of select="document(../src/nounCommon_smenob.xml)/r/e">
    <xsl:copy-of select="document(../src/nounProper_smenob.xml)/r/e">
    <xsl:copy-of select="document(../src/other_smenob.xml)/r/e">
    <xsl:copy-of select="document(../src/verb_smenob.xml)/r/e">
    </r>
</xsl:template>

</xsl:stylesheet>
