<?xml version="1.0"?>
<!--+
    | 
    | compares (ped vs. smenob) and put ped-flags on smenob-entries 
    | Usage: java net.sf.saxon.Transform -it main cfSmeSmj.xsl
    +-->

<!-- java -Xmx2048m net.sf.saxon.Transform -it main cfPED_resources.xsl ped_file=xml/nouns.xml smenob_file=../src/nounCommon_smenob.xml -->
<!-- java -Xmx2048m net.sf.saxon.Transform -it main flagSmenob.xsl ped_file=xml/adjectives.xml smenob_file=../src/adjective_smenob.xml  -->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs local">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
	      omit-xml-declaration="no"
              doctype-system="../scripts/smenob.dtd"
              doctype-public="-//XMLmind//DTD smenob//SE"
	      indent="yes"/>

 <xsl:output method="text" name="txt"/>


 <!-- TODO: a module for the whole functions to use them globally -->

  <xsl:function name="local:substring-before-if-contains" as="xs:string?">
    <xsl:param name="arg" as="xs:string?"/> 
    <xsl:param name="delim" as="xs:string"/> 
    
    <xsl:sequence select=" 
			  if (contains($arg,$delim))
			  then substring-before($arg,$delim)
			  else $arg
			  "/>
  </xsl:function>
  
  <xsl:function name="local:value-intersect" as="xs:anyAtomicType*">
    <xsl:param name="arg1" as="xs:anyAtomicType*"/> 
    <xsl:param name="arg2" as="xs:anyAtomicType*"/> 
    
    <xsl:sequence select=" 
			  distinct-values($arg1[.=$arg2])
			  "/>
  </xsl:function>

  <xsl:function name="local:value-except" as="xs:anyAtomicType*">
    <xsl:param name="arg1" as="xs:anyAtomicType*"/> 
    <xsl:param name="arg2" as="xs:anyAtomicType*"/> 
    
    <xsl:sequence select=" 
			  distinct-values($arg1[not(.=$arg2)])
			  "/>
  </xsl:function>
  

  <xsl:function name="local:is-node-in-sequence" as="xs:boolean">
    <xsl:param name="node" as="node()?"/> 
    <xsl:param name="seq" as="node()*"/> 
    
    <xsl:sequence select=" 
			  some $nodeInSeq in $seq satisfies $nodeInSeq is $node
			  "/>
  </xsl:function>
  
  
  
  <!-- Input files -->
  <xsl:param name="ped_file" select="'ped_file.default'"/>
  <xsl:param name="smenob_file" select="'smenob_file.default'"/>

  <!-- Output files -->
  <xsl:variable name="outputDir" select="'CompResults'"/>
  <xsl:variable name="intersection" select="concat('intersect-', $ped_file_name, '_', $smenob_file_name)"/>
  <xsl:variable name="difference" select="concat('diff-', $ped_file_name, '_', $smenob_file_name)"/>

  
  <!-- Patterns for the feature values -->
  <xsl:variable name="output_format" select="'xml'"/>
  <xsl:variable name="e" select="$output_format"/>
  <!-- <xsl:variable name="outputDir" select="'xml-out'"/> -->
  <xsl:variable name="ped_file_name" select="substring-before((tokenize($ped_file, '/'))[last()], '.xml')"/>
  <xsl:variable name="smenob_file_name" select="substring-before((tokenize($smenob_file, '/'))[last()], '.xml')"/>
  
  
  
  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="doc-available($ped_file) and doc-available($smenob_file)">
	
	<xsl:variable name="pedEntries">
	  <entries>
	    <xsl:for-each select="doc($ped_file)/r/l">
	      <xsl:copy-of select="."/>
	    </xsl:for-each>
	  </entries>
	</xsl:variable>
	
	<xsl:variable name="smenobEntries">
	  <entries>
	    <xsl:for-each select="doc($smenob_file)/r/e">
	      <xsl:copy-of select="./lg/l"/>
	    </xsl:for-each>
	  </entries>
	</xsl:variable>
	
	<!-- compute the intersection set between ped- and smenob-entries -->
	<xsl:variable name="commonEntries">
	  <r>
	    <xsl:for-each select="local:value-intersect(distinct-values($pedEntries/entries/l), distinct-values($smenobEntries/entries/l))">
	      <l>
		<xsl:value-of select="."/>
	      </l>
	    </xsl:for-each>
	  </r>
	</xsl:variable>


	<!-- compute the set which are only in ped but not in smenob -->
<!-- 	<xsl:variable name="commonEntries"> -->
<!-- 	  <r> -->
<!-- 	    <xsl:for-each select="local:value-except(distinct-values($pedEntries/entries/l), distinct-values($smenobEntries/entries/l))"> -->
<!-- 	      <l> -->
<!-- 		<xsl:value-of select="."/> -->
<!-- 	      </l> -->
<!-- 	    </xsl:for-each> -->
<!-- 	  </r> -->
<!-- 	</xsl:variable> -->

	
	<!-- output the flagged smenob -->
	<xsl:result-document href="{$outputDir}/{$smenob_file_name}.{$e}" format="{$output_format}">
	  <r>
	    <xsl:for-each select="doc($smenob_file)/r/e">
	      <xsl:choose>
		<xsl:when test="local:value-intersect(./lg/l, $commonEntries/r/l)">
		  <e>
		    <xsl:for-each select="./@*">
		      <xsl:copy-of select="."/>
		    </xsl:for-each>
		    <xsl:attribute name="src">
		      <xsl:value-of select="'rj'"/>
		    </xsl:attribute>
		    <xsl:copy-of select="./node()"/>
		  </e>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:copy-of select="."/>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
	  </r>
	</xsl:result-document>
	
	

	<!--         output intersection -->
<!-- 	<xsl:result-document href="{$outputDir}/{$intersection}.{$e}" format="{$output_format}"> -->
<!-- 	  <xsl:copy-of select="$commonEntries"/> -->
<!-- 	</xsl:result-document> -->



<!-- 	output difference -->
<!-- 	<xsl:result-document href="{$outputDir}/{$difference}.{$e}" format="{$output_format}"> -->
<!-- 	  <xsl:copy-of select="$commonEntries"/> -->
<!-- 	</xsl:result-document> -->



	 <!--          <xsl:copy-of select="$pedEntries"/> -->
	 <!--          <xsl:copy-of select="$smenobEntries"/> -->
<!-- 	<xsl:text> -->
<!-- </xsl:text> -->
	
	<!-- preprocessing work -->
	
	<!-- compute and output the intersection set: elements that are both in file 1 and in file 2 -->
<!-- 	<xsl:result-document href="{$outputDir}/{$intersection}.{$e}" format="{$output_format}"> -->
<!-- 	  <r> -->
<!-- 	    <xsl:for-each select="local:value-intersect(distinct-values($pedEntries/entries/l), distinct-values($smenobEntries/entries/l))"> -->
<!-- 	      <l> -->
<!-- 		<xsl:value-of select="if ($output_format = 'txt') then concat(., '&#xa;') -->
<!-- 				      else -->
<!-- 				        if ($output_format = 'xml') then . -->
<!-- 				      else ''"/> -->
<!-- 	      </l> -->
<!-- 	    </xsl:for-each> -->
<!-- 	  </r> -->
<!-- 	</xsl:result-document> -->



	<!-- compute and output the difference set: elements that are only in file 1 but not in file 2 -->
<!-- 	<xsl:result-document href="{$outputDir}/{$difference}.{$e}" format="{$output_format}"> -->
<!-- 	  <r> -->
<!-- 	    <xsl:for-each select="local:value-except(distinct-values($pedEntries/entries/l), distinct-values($smenobEntries/entries/l))"> -->
<!-- 	      <l> -->
<!-- 		<xsl:choose> -->
<!-- 		  <xsl:when test="$output_format = 'txt'"> -->
<!-- 		    <xsl:value-of select="concat(., '&#xa;')"/> -->
<!-- 		  </xsl:when> -->
<!-- 		  <xsl:when test="$output_format = 'xml'"> -->
<!-- 		    <xsl:value-of select="."/> -->
<!-- 		  </xsl:when> -->
<!-- 		</xsl:choose> -->
<!-- 	      </l> -->
<!-- 	    </xsl:for-each> -->
<!-- 	  </r> -->
<!-- 	</xsl:result-document> -->




	<!-- old stuff -->
	
	<!-- compute and output the difference set: elements that are only in file 2 but not in file  -->
<!-- 	<xsl:result-document href="{$outputDir}/{$difference}.{$e}"> -->
<!-- 	  <r> -->
<!-- 	    <xsl:for-each select="local:value-except(distinct-values($sme_smj_list/word), distinct-values($sme_list/word))"> -->
<!-- 	      <word> -->
<!-- 		<xsl:value-of select="concat(., '&#xa;')"/> -->
<!-- 	      </word> -->
<!-- 	    </xsl:for-each> -->
<!-- 	  </r> -->
<!-- 	</xsl:result-document> -->

      </xsl:when>
      <xsl:otherwise>
	<xsl:choose>
	  <xsl:when test="doc-available($ped_file)">
	    <xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$smenob_file"/><xsl:text>&#xa;</xsl:text>
	  </xsl:when>
	  <xsl:when test="doc-available($smenob_file)">
	    <xsl:text>Cannot locate: </xsl:text><xsl:value-of select="$ped_file"/><xsl:text>&#xa;</xsl:text>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:text>Neither </xsl:text><xsl:value-of select="$smenob_file"/>
	    <xsl:text> nor </xsl:text><xsl:value-of select="$ped_file"/><xsl:text> can be located!&#xa;</xsl:text>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

