<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
		version="1.0"
                extension-element-prefixes="xt">

<!--

kreita de Wolfram Diestel

-->

<xsl:import href="bibhtml.xsl"/>

<xsl:template match="bibliografio">
  <dl>
  <!-- ordigu lau lau titolo  -->
  <xsl:apply-templates select="vrk/tit" mode="inx">
    <xsl:sort select="." lang="eo"/>
  </xsl:apply-templates>
  </dl>
</xsl:template>

<xsl:template match="tit" mode="inx">
  <dt>
    <strong>
      <xsl:apply-templates/>
    </strong>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="ancestor::vrk" mode="mll"/>
  </dt>
  <dd>
    <xsl:apply-templates select="ancestor::vrk"/>
  </dd>
</xsl:template>

<xsl:template match="tit"/>

<xsl:template match="vrk" mode="mll">
  <xsl:choose>
    <xsl:when test="url">
      <a href="{url}" target="_new">
      <b>[<xsl:value-of select="@mll"/>]</b>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <b>[<xsl:value-of select="@mll"/>]</b>
    </xsl:otherwise>
  </xsl:choose>  
</xsl:template>

<xsl:template match="vrk">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="aut">
  <xsl:apply-templates/>
  <xsl:choose>
    <xsl:when test="following-sibling::*[1][self::aut]">
      <xsl:text>; </xsl:text>
    </xsl:when>
    <xsl:when test="following-sibling::*[1][self::trd]">
      <xsl:text>, </xsl:text><br/>
    </xsl:when>
    <xsl:when test="following-sibling::*[1][self::tit]">
      <xsl:text>, </xsl:text><br/>
    </xsl:when>
  </xsl:choose>
</xsl:template>




</xsl:stylesheet>











