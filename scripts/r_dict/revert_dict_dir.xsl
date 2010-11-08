<?xml version="1.0"?>
<!--+
    | 
    | script to generated dictionaries from a given gt_dict file
    | Usage: java net.sf.saxon.Transform -it main THIS_SCRIPT inFile=DICT_FILE
    +-->

<!-- java -Xmx2048m net.sf.saxon.Transform -it main revert_dict.xsl inDir= -->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs local xhtml">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>

  
  <!-- Input files -->
  <xsl:param name="inDir" select="'yid'"/>

  <!-- Output dir, files -->
  <xsl:variable name="outDir" select="'yod'"/>
  <!-- use only the first translation -->
  <xsl:variable name="modus" select="'all'"/>
  <!--   <xsl:variable name="modus" select="'only_one'"/> -->
  <!-- source language -->
  <xsl:param name="srcl" select="'sme'"/>
  <!-- target language -->
  <xsl:param name="trgl" select="'nob'"/>
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
      
      <xsl:variable name="out_tmp">
	<r xml:lang="{$trgl}">
	  <xsl:for-each select="./r/e">
	    
	    <xsl:for-each select="./mg/tg/t | ./mg/tg/tf">
	      <e>
		<lg>
		  <l>
		    <xsl:attribute name="pos">
		      <xsl:value-of select="if (@pos and not(@pos = '')) then @pos else 'xxx'"/>
		    </xsl:attribute>
		    <xsl:copy-of select="./@*[not(local-name() = 'oa')]
					 [not(local-name() = 'context')]
					 [not(local-name() = 'tcomm')]
					 [not(local-name() = 'dict')]
					 [not(local-name() = 'pos')]"/>

<!-- 		    <xsl:if test=""> -->
<!-- 		      <xsl:attribute name="decl"> -->
<!-- 			<xsl:value-of select="if (@pos and not(@pos = '')) then @pos else 'xxx'"/> -->
<!-- 		      </xsl:attribute> -->
<!-- 		    </xsl:if> -->

		    <xsl:value-of select="normalize-space(.)"/>
		  </l>
		</lg>
		<mg>
		  <!-- as CLT agreed upon, the interim representation of the reverted dictionaries will get the lang tag on the meaning group -->
		  <!-- Is there a problem for Cip's dream: tante vs. faster/moster; søskenbarn vs. kusin; fetter, kusine vs. kusin? -->
		  <xsl:attribute name="xml:lang">
		    <xsl:value-of select="$srcl"/>
		  </xsl:attribute>
		  <tg>
		    <xsl:copy-of select="../re"/>
		    <xsl:for-each select="../te">
		      <re>
			<xsl:value-of select="."/>
		      </re>
		    </xsl:for-each>
		    <t>
		      <!-- not needed yet on the t element: it is on the mg element -->
		      <!-- 		      <xsl:attribute name="xml:lang"> -->
		      <!-- 			<xsl:value-of select="$srcl"/> -->
		      <!-- 		      </xsl:attribute> -->
		      <!-- transfer sme-relevant attributes to the nobsme as production dictionary -->
		      <xsl:copy-of select="../../../lg/l/@*[not(local-name() = 'oa')]
					   [not(local-name() = 'tcomm')]
					   [not(local-name() = 'dict')]"/>
		      <xsl:copy-of select="./@context"/>
		      <xsl:value-of select="normalize-space(../../../lg/l)"/>
		    </t>
		    <xsl:if test="../xg">
		      <xsl:for-each select="../xg">
			<xg>
			  <xsl:for-each select="./xt">
			    <x>
			      <xsl:value-of select="."/>
			    </x>
			  </xsl:for-each>
			  <xt>
			    <xsl:value-of select="./x"/>
			  </xt>
			</xg>
		      </xsl:for-each>
		    </xsl:if>
		  </tg>
		</mg>
	      </e>
	    </xsl:for-each>
	  </xsl:for-each>
	</r>
      </xsl:variable>
      
      <xsl:result-document href="{$outDir}/{concat(substring-before($current_file, '_'), '_', $trgl, $srcl)}.{$e}" format="{$of}">
	<xsl:copy-of select="$out_tmp"/>
      </xsl:result-document>
      
    </xsl:for-each>
    
  </xsl:template>
  
<!--   <xsl:template match="*"> -->
<!--     <xsl:element name="{local-name()}"> -->
<!--       <xsl:apply-templates select="*"/> -->
<!--     </xsl:element> -->
<!--   </xsl:template> -->
  


</xsl:stylesheet>


