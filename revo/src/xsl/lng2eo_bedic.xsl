<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 2004 che Wolfram Diestel, GPL 2.0

elfiltras tradukojn de unu lingvo kaj preparas por la
bedic-formato. Donu kiel parametron la elfiltrendan
lingvon. Che xsltproc ekz. per -stringparam lng=fr

-->

<xsl:output method="text" encoding="utf-8"/>
<xsl:strip-space elements="trdk trd kap"/>


<!--xsl:template match="trdk"/ -->

<xsl:key name="kapoj" match="//trdk/trd" use="."/>


<xsl:template match="trdoj">
  <xsl:text>Revo: </xsl:text>
  <xsl:value-of select="//trdk[1]/@lng"/>
  <xsl:text>-eo#INFO#</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="art">
    <xsl:for-each select="trdk/trd
           [count(.|key('kapoj',.)[1])=1]">

        <xsl:apply-templates select="."/><xsl:text>#KAPO#
{s}</xsl:text>

   <xsl:for-each select="key('kapoj',.)">
        <xsl:text>{ss}</xsl:text>
	<xsl:apply-templates select="../kap"/>
        <xsl:text>{/ss}</xsl:text>
   </xsl:for-each><xsl:text>{/s}#FINO#
</xsl:text>

    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>














