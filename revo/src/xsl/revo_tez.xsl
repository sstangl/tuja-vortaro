<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon"
>

<xsl:variable name="verbose" select="'false'"/>
<xsl:variable name="debug" select="'false'"/>

<xsl:variable name="file" select="document-uri(/)"/>
<xsl:variable name="base" select="string-join(tokenize($file,'/')[position() &lt; last()-1],'/')"/>
<xsl:variable name="tez-pad" select="'../tez/'"/>

<xsl:template match="/">
  <xsl:if test="$debug='true'">
    <xsl:message>tez-dir: <xsl:value-of select="concat($base,'/tez/')"/></xsl:message>
  </xsl:if>

  <xsl:apply-templates/>
</xsl:template>
 

<!-- se tezauro ankau eblu el subdrv, necesus aldoni when-parton
  en tez-mrk-n kun format="A" kaj same trakto de tio en tez_retigo.xsl -->

<xsl:template match="drv|snc|subsnc">
  <xsl:variable name="tez-mrk">
    <xsl:choose>
      <xsl:when test="self::drv[count(snc)=1]">
         <xsl:value-of select="@mrk"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="tez-mrk-n"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="tez-doc" select="concat('tz_',translate($tez-mrk,'.','_'),'.html')"/>

<xsl:if test="$debug='true'">
   <xsl:message><xsl:value-of select="$tez-doc"/></xsl:message>
</xsl:if>
 

  <xsl:copy>
    <xsl:if test="@mrk">
       <xsl:attribute name="mrk"><xsl:value-of select="@mrk"/></xsl:attribute>
    </xsl:if>

    <xsl:if test="doc-available(concat($base,'/tez/',$tez-doc))">

<xsl:if test="$verbose='true' or $debug='true'">
       <xsl:message>tez: <xsl:value-of select="$tez-doc"/>
</xsl:message>
</xsl:if>

      <xsl:attribute name="tez"><xsl:value-of select="concat($tez-pad,$tez-doc)"/></xsl:attribute>
    </xsl:if>
   
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>



<!-- devas esti same kiel en tez_retigo.xsl -->
<xsl:template name="tez-mrk-n">
   <xsl:choose>
      <xsl:when test="@mrk">
         <xsl:value-of select="@mrk"/>
      </xsl:when>

      <xsl:otherwise>
         <xsl:value-of select="ancestor::node()[@mrk][1]/@mrk"/><xsl:text>.</xsl:text>
         <xsl:number from="drv|subart" level="multiple" count="snc|subsnc" format="1.a"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>


<xsl:template match="*|text()|@*">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>



</xsl:transform>

