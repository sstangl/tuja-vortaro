<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 2004 che Wolfram Diestel, GPL 2.0

elfiltras tradukojn de unu lingvo. 
Donu kiel parametron la elfiltrendan
lingvon. Che xsltproc ekz. per -stringparam lng=fr

-->


<xsl:output method="xml" version="1.0" encoding="utf-8"/>
<xsl:strip-space elements="trdgrp refgrp kap"/>
<xsl:param name="lng" select="'de'"/>

<xsl:template match="art">
  <art><xsl:apply-templates select="//trd[@lng=$lng]|//trdgrp[@lng=$lng]"/></art>
</xsl:template>

<!-- tildoj referencas al la radiko de la artikola kapvorto -->

<xsl:template match="tld" mode="kapvorto">
  <xsl:choose>

    <xsl:when test="@lit">
      <xsl:value-of select="concat(@lit,substring(ancestor::art/kap/rad,2))"/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:value-of select="ancestor::art/kap/rad"/>
    </xsl:otherwise>

  </xsl:choose>
</xsl:template>

<!-- moduso "kapvorto" - kunmetu la kapvorton por traduko au administra noto -->

<xsl:template match="art|drv" mode="kapvorto">
  <xsl:apply-templates select="kap" mode="kapvorto"/>
</xsl:template>


<xsl:template match="snc" mode="kapvorto">

  <xsl:apply-templates select="ancestor::node()
    [self::drv or self::art][1]/kap" mode="kapvorto"/>
<!--    <xsl:text> </xsl:text>

    <xsl:choose>

      <xsl:when test="@ref">
        <xsl:apply-templates mode="number-of-ref-snc" select="id(@ref)"/>:
      </xsl:when>

      <xsl:when test="count(ancestor::node()
        [self::drv or self::subart][1]//snc)>1">
        <xsl:number from="drv|subart" level="any" count="snc" format="1."/>
      </xsl:when>

    </xsl:choose>
-->
</xsl:template>


<xsl:template match="subsnc" mode="kapvorto">
  <xsl:apply-templates select="ancestor::node()
    [self::drv or self::art][1]/kap" mode="kapvorto"/>
<!--  <xsl:text> </xsl:text>
  <xsl:number format="a"/>-->
</xsl:template>


<xsl:template match="subart" mode="kapvorto">
  <xsl:apply-templates select="ancestor::art/kap" mode="kapvorto"/>
<!--  <xsl:text> </xsl:text>
  <xsl:number format="I"/>-->
</xsl:template>

<xsl:template match="subdrv" mode="kapvorto">
  <xsl:apply-templates select="ancestor::drv/kap" mode="kapvorto"/>
<!--  <xsl:text> </xsl:text>
  <xsl:number format="A"/>-->
</xsl:template>

<xsl:template match="kap" mode="kapvorto">
  <xsl:apply-templates select="tld|rad|text()" mode="kapvorto"/>
</xsl:template>

<!-- la sekvaj necesas nur por tradukoj en ekzemploj kaj bildoj -->

<xsl:template match="ekz|bld" mode="kapvorto">
  <xsl:apply-templates select="ind" mode="kapvorto"/>
</xsl:template>

<xsl:template match="ind" mode="kapvorto">
  <xsl:choose>
    <xsl:when test="mll">
      <xsl:apply-templates select="mll" mode="kapvorto"/> 
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates mode="kapvorto"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="ind/mll" mode="kapvorto">
  <xsl:if test="@tip='fin' or @tip='mez'">
    <xsl:text>...</xsl:text>
  </xsl:if>
  <xsl:apply-templates mode="kapvorto"/>
  <xsl:if test="@tip='kom' or @tip='mez'">
    <xsl:text>...</xsl:text>
  </xsl:if>
</xsl:template>




<!-- traktas unuopan tradukon au tradukgrupon -->

<xsl:template match="trd[@lng]|trdgrp">
    <!-- rigardu, al kiu subarbo apartenas la traduko kaj skribu la
    tradukitan vorton/sencon -->
      
<trdk lng="{@lng}">
<kap>
	<xsl:apply-templates 
        select="ancestor::node()[
          self::drv or 
          self::snc or 
          self::subsnc or
          self::subdrv or 
          self::subart or 
          self::art or 
          self::ekz or
          self::bld][1]" mode="kapvorto"/>
</kap>
  <!-- skribu la tradukon mem --> 

    <xsl:choose>
      <xsl:when test="trd">
          <xsl:apply-templates select="trd" mode="tradukoj"/>
      </xsl:when>
      <xsl:otherwise>
        <trd><xsl:apply-templates mode="tradukoj"/></trd>
      </xsl:otherwise>
    </xsl:choose>
</trdk><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="trdgrp/trd" mode="tradukoj">
  <trd>
  <xsl:apply-templates mode="tradukoj"/>
  </trd>
</xsl:template>

<xsl:template match="klr" mode="tradukoj">
  <klr tip="{@tip}">
  <xsl:apply-templates/>
  </klr>
</xsl:template>

</xsl:stylesheet>














