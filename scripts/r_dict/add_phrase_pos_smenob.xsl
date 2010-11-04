<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inputDir=DIR
    |  Script to add pos="phrase" to the <t> and <tf> elements that contain more than one word.
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:param name="inFile" select="'gogo_file'"/>
  <xsl:param name="inDir" select="'ind'"/>
  <xsl:variable name="outDir" select="'outx'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="'true_gogo'"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="slang" select="'sme'"/>
  <xsl:variable name="tlang" select="'nob'"/>
  
  <xsl:template match="/" name="main">

    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      
      <xsl:if test="$debug = 'true_gogo'">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>
      
      <xsl:variable name="cufi">
	<r xml:lang="{$slang}">
	  <xsl:for-each select="./r/e">
	    <e>
	      <xsl:copy-of select="./@*"/>
	      <xsl:copy-of select="./lg"/>
	      <xsl:for-each select="./mg">
		<mg>
		  <xsl:for-each select="./tg">
		    <tg>
		      <xsl:for-each select="./*">
			<xsl:if test="(local-name() = 'xg') or 
				      (local-name() = 're') or 
				      (local-name() = 'te')">
			  <xsl:copy-of select="."/>
			</xsl:if>
			
			<xsl:if test="((local-name() = 't') and (count(tokenize(normalize-space(text()), ' ')) = 1))">
			  <xsl:element name="{local-name()}">
			    <xsl:copy-of select="./@*[not(local-name() = 'oa')][not(local-name() = 'tcomm')][not(local-name() = 'dict')]"/>
			    <xsl:value-of select="normalize-space(.)"/>
			  </xsl:element>
			</xsl:if>
			
			<xsl:if test="(local-name() = 'tf') or ((local-name() = 't') and (count(tokenize(normalize-space(text()), ' ')) &gt; 1))">
			  <tf>
			    <xsl:attribute name="pos">
			      <xsl:value-of  select="'phrase'"/>
			    </xsl:attribute>
			    <xsl:copy-of select="./@*[not(local-name() = 'pos')][not(local-name() = 'oa')][not(local-name() = 'tcomm')][not(local-name() = 'dict')]"/>
			    <xsl:value-of select="normalize-space(.)"/>
			  </tf>
			</xsl:if>
			
		      </xsl:for-each>
		    </tg>
		  </xsl:for-each>
		</mg>
	      </xsl:for-each>
	    </e>
	  </xsl:for-each>
	</r>
      </xsl:variable>
      
      <xsl:result-document href="{$outDir}/{$current_file}" format="{$of}">
	<xsl:copy-of select="$cufi"/>
      </xsl:result-document>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>
