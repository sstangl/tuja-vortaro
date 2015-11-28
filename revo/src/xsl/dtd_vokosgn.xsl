<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="text" encoding="utf-8"/>

<xsl:template match="/">
  <xsl:text>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
  &lt;!-- tiu chi dosiero estas automate farita el voko/cfg/literoj.xml --&gt;
</xsl:text>
  <xsl:apply-templates select="literoj/l"/>
</xsl:template>

<xsl:template match="l">
  <xsl:text>&lt;!ENTITY </xsl:text>
  <xsl:value-of select="@nomo"/>
  <xsl:text> &quot;&amp;</xsl:text>
  <xsl:value-of select="@kodo"/>
  <xsl:text>;&quot;&gt;
</xsl:text>
</xsl:template>


</xsl:stylesheet>