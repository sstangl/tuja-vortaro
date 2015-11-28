<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="text" encoding="utf-8"/>

<xsl:template match="/">
  <xsl:text>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!-- tiu chi dosiero estas automate farita el voko/cfg/ordigo2.xml --&gt;
&lt;!DOCTYPE xsl:transform [
</xsl:text>
  <xsl:apply-templates select="ordigo/lingvo[@kreu-regulojn='jes']"
     mode="entities"/>
<xsl:text>]&gt;
&lt;xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon"&gt;
</xsl:text>

  <xsl:apply-templates select="ordigo/lingvo[@kreu-regulojn='jes']" 
     mode="collations"/>

<xsl:text>
&lt;xsl:template name="trd-litero"&gt;
  &lt;xsl:param name="trdoj"/&gt;
  &lt;xsl:param name="ordlng"/&gt;
  &lt;xsl:param name="lit-name"/&gt;
  &lt;xsl:param name="lit-min"/&gt;

  &lt;xsl:choose&gt;
</xsl:text>
  <xsl:apply-templates select="ordigo/lingvo[@kreu-regulojn='jes' and not(@lng='eo')]" 
     mode="template"/>
<xsl:text>
    &lt;xsl:otherwise&gt;
      &lt;litero name="{$lit-name}" min="{$lit-min}"&gt;
        &lt;xsl:for-each select="$trdoj"&gt;
          &lt;xsl:sort lang="{$ordlng}" select="concat(t,'|',t1)"/&gt;
          &lt;xsl:call-template name="v"/&gt;
        &lt;/xsl:for-each&gt;
      &lt;/litero&gt;
    &lt;/xsl:otherwise&gt;
  &lt;/xsl:choose&gt;
&lt;/xsl:template&gt;

&lt;/xsl:transform&gt;
</xsl:text>
</xsl:template>


<xsl:template match="lingvo" mode="entities">
  <xsl:text>
&lt;!ENTITY sort-</xsl:text><xsl:value-of select="@lng"/>
<xsl:text> " = '|'</xsl:text>
<xsl:apply-templates select="i"/>
<xsl:apply-templates select="l"/>
<xsl:apply-templates select="r"/>
<xsl:text>"&gt;
</xsl:text>
</xsl:template>


<xsl:template match="lingvo" mode="collations">
<xsl:text>&lt;saxon:collation name="</xsl:text>
<xsl:value-of select="@lng"/>
<xsl:text>" lang="</xsl:text>
<xsl:value-of select="@lng"/>
<xsl:text>" rules="&amp;sort-</xsl:text>
<xsl:value-of select="@lng"/>
<xsl:text>;"/&gt;
</xsl:text>
</xsl:template>


<xsl:template match="lingvo" mode="template">
<xsl:text>
  &lt;xsl:when test="$ordlng='</xsl:text>
<xsl:value-of select="@lng"/>
<xsl:text>'"&gt;
      &lt;litero name="{$lit-name}" min="{$lit-min}"&gt;
        &lt;xsl:for-each select="$trdoj"&gt;
          &lt;xsl:sort collation="</xsl:text>
<xsl:value-of select="@lng"/>
<xsl:text>" lang="</xsl:text>
<xsl:value-of select="@lng"/>
<xsl:text>" select="concat(t,'|',t1)"/&gt;
          &lt;xsl:call-template name="v"/&gt;
        &lt;/xsl:for-each&gt;
      &lt;/litero&gt;        
    &lt;/xsl:when&gt;
</xsl:text>
</xsl:template>


<xsl:template match="i">
  <xsl:text> = </xsl:text>
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="l">
  <xsl:text> &amp;lt; </xsl:text>
  <xsl:value-of select="."/>
</xsl:template>


<xsl:template match="r">
  <xsl:text> &amp;amp; </xsl:text>
  <xsl:value-of select="."/>
</xsl:template>


</xsl:stylesheet>