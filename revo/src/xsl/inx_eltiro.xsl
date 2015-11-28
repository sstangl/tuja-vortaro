<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<xsl:output method="xml" encoding="utf-8" indent="no"/>
<xsl:strip-space elements="kap"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="art">
  <art mrk="{substring-after(substring-before(@mrk,'.xml'),'Id: ')}">
  <xsl:apply-templates select="kap|subart|drv|snc|trdgrp|trd|uzo|bld|dif|ekz|tezrad"/>
  </art>
</xsl:template>

<xsl:template match="subart|drv|subdrv|snc|subsnc">
  <xsl:copy>
  <xsl:apply-templates select="@mrk|kap|drv|subdrv|snc|subsnc|trdgrp|trd
          |uzo|bld|dif|ekz|mlg|refgrp|ref|tezrad|rim"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="dif">
  <xsl:apply-templates select="ekz|trdgrp|trd|refgrp|ref"/>
</xsl:template>

<xsl:template match="ekz[ind]">
  <xsl:copy>
  <xsl:apply-templates select="ind|trdgrp|trd"/>
  </xsl:copy> 
</xsl:template>

<xsl:template match="ekz"/>

<xsl:template match="rim">
  <xsl:apply-templates select="ref"/>
</xsl:template>

<xsl:template match="trdgrp">
  <xsl:variable name="lng" select="@lng"/>
  <xsl:for-each select="trd">
    <trd lng="{$lng}">
      <xsl:choose>
        <xsl:when test="mll">
          <xsl:apply-templates select="mll"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </trd>
  </xsl:for-each>
</xsl:template>

<xsl:template match="trd[@lng]">
  <xsl:copy>
      <xsl:choose>
        <xsl:when test="mll">
          <xsl:apply-templates select="@lng|mll"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@lng|text()|ind|klr[@tip='ind' or @tip='amb']"/>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:copy>
</xsl:template>

<xsl:template match="kap/ofc|kap/fnt|ekz/uzo|trd/ofc
  |klr[not(@tip='ind' or @tip='amb')]"/>

<xsl:template match="ekz/ind[mll]">
  <xsl:copy><xsl:apply-templates select="mll"/></xsl:copy>
</xsl:template>

<xsl:template match="kap|rad|var|@mrk|@lng|uzo[@tip='fak']|bld|mlg
  |ind|klr[@tip='ind' or @tip='amb']">
  <xsl:copy><xsl:apply-templates/></xsl:copy>
</xsl:template>

<xsl:template match="tld">
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="mll">
  <mll tip="{@tip}">
    <xsl:apply-templates/>
  </mll>
</xsl:template>

<xsl:template match="refgrp">
  <xsl:apply-templates select="ref"/>
</xsl:template>

<xsl:template match="ref">
  <ref tip="{ancestor-or-self::*/@tip}" cel="{@cel}"/>
</xsl:template>

<xsl:template match="tezrad">
  <xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>










