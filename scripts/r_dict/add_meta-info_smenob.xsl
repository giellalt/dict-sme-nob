<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inputDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="xs">

  <xsl:strip-space elements="*"/>
  <!--   <xsl:preserve-space elements="lics lic sourcenote"/> -->
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      doctype-system="../../scripts/gt_dictionary.dtd"
	      doctype-public="-//DivvunGiellatekno//DTD Dictionaries//Multilingual"
	      indent="yes"/>
  
  <xsl:param name="inFile" select="'gogo_file'"/>
  <xsl:param name="inDir" select="'ind'"/>
  <xsl:variable name="outDir" select="'outxxx'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="'true_gogo'"/>
  <xsl:variable name="nl" select="'&#xa;'"/>

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
      
      <xsl:if test="not(count(.//e) = 0)">      
	<xsl:result-document href="{$outDir}/{$current_file}" format="{$of}">
	  
	  <xsl:processing-instruction name="xml-stylesheet">
	    <xsl:text>title="Dictionary view" media="screen,tv,projection" href="../../scripts/gt_dictionary.css" type="text/css"</xsl:text>
	  </xsl:processing-instruction>
	  
	  <xsl:value-of select="$nl"/>
	  
	  <xsl:processing-instruction name="xml-stylesheet">
	    <xsl:text>alternate="yes" title="Hierarchical view" media="screen,tv,projection" href="../../scripts/gt_dictionary_alt.css" type="text/css"</xsl:text>
	  </xsl:processing-instruction>
	  
	  <xsl:value-of select="$nl"/>
	  <r>
	    <xsl:copy-of select="./r/@*"/>
   <lics xml:space="preserve">
      <lic xml:lang="en">
This code is made available under a Creative Commons Attribution license
<a>http://creativecommons.org/licenses/by/3.0/no/deed.en</a>.

You are free to copy, distribute and adapt the work, as long as you always give
proper attribution using the attribution text below.

For the full license text, see the link above.</lic>
      <ref>Work by Nils Jernsletten, Giellatekno at UiT, Divvun at the
          Norwegian Saami Parliament,
          and members of the language communities. Source code
          available at <a>https://victorio.uit.no/langtech/trunk/</a>.</ref>
      <sourcenote>
     THIS TEXT IS THE ORIGINAL SOURCE CODE. This is NOT a fully styled and
     published dictionary. As such it can and
     will contain unfinished entries, unpublished entries, entries with
     objectionable translations, etc. If you find any errors or want to add more
     words, download the file, edit it, and send it back to
     <a>mailto:divvun@samediggi.no</a> and <a>mailto:giellatekno@hum.uit.no</a>.
     Please also note that the entries are not necessarily sorted,
     or could be wrongly sorted.
     </sourcenote>
   </lics>
	    <xsl:copy-of select="./r/*"/>
	    <xhtml:script src="../../scripts/gt_dictionary.js" type="text/javascript" xmlns:xhtml="http://www.w3.org/1999/xhtml" />
	  </r>
	</xsl:result-document>
      </xsl:if>
    </xsl:for-each>
    
  </xsl:template>
  
</xsl:stylesheet>
