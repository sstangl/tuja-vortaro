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
  <!-- ordigu lau lau autoro...  -->
  <xsl:apply-templates select="vrk/aut/n|vrk/trd/n" mode="inx">
    <xsl:sort select="."/>
  </xsl:apply-templates>
  </dl>
</xsl:template>

<xsl:template match="aut/n" mode="inx">
  <dt>
    <strong>
      <xsl:apply-templates select="ancestor::aut" mode="inx"/>
    </strong>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="ancestor::vrk" mode="mll"/>
  </dt>
  <dd>
    <xsl:apply-templates select="ancestor::vrk"/>
  </dd>
</xsl:template>

<xsl:template match="trd/n" mode="inx">
  <dt>
    <strong>
      <xsl:apply-templates select="ancestor::trd" mode="inx"/>
    </strong>
    (trad.)
    <xsl:apply-templates select="ancestor::vrk" mode="mll"/>
  </dt>
  <dd>
    <xsl:apply-templates select="ancestor::vrk"/>
  </dd>
</xsl:template>

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

<xsl:template match="aut|trd" mode="inx">
  <xsl:choose>
    <xsl:when test="n">
      <xsl:value-of select="n"/>
      <xsl:if test="a">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="a"/>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



</xsl:stylesheet>











