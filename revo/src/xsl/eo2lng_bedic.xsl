<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 1999-2003 che Wolfram Diestel 

reguloj por prezentado de la tradukoj

-->


<xsl:output method="text" encoding="utf-8"/>
<xsl:strip-space elements="trdk trd kap"/>

<!--xsl:template match="trdk"/ -->

<xsl:key name="kapoj" match="//trdk" use="kap"/>

<xsl:template match="trdoj">
  <xsl:text>Revo: eo-</xsl:text>
  <xsl:value-of select="//trdk[1]/@lng"/>
  <xsl:text>#INFO#</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="art">
    <xsl:for-each select="(trdk)
           [count(.|key('kapoj',kap)[1])=1]">
    <xsl:apply-templates select="kap"/><xsl:text>#KAPO#
{s}</xsl:text>
   <xsl:for-each select="key('kapoj',kap)">
      <xsl:for-each select="trd">
        <xsl:text>{ss}</xsl:text><xsl:apply-templates/><xsl:text>{/ss}</xsl:text>
      </xsl:for-each>
        </xsl:for-each><xsl:text>{/s}#FINO#
</xsl:text>
    </xsl:for-each>
</xsl:template>


</xsl:stylesheet>














