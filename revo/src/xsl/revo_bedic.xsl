<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">


<!-- (c) 1999-2003 che Wolfram Diestel 
     licenco GPL 2.0

reguloj por simpla HTML tauga al transformado al
simpla teksto per lynx -dump -nolist

tie chi trovighas nur variabloj por agordo kaj la
importkomandoj por la unuopaj dosieroj, kie enestas la
transform-reguloj

-->

<xsl:import href="revo_trd.xsl"/>
<xsl:import href="revo_fnt.xsl"/>
<xsl:import href="revo_adm.xsl"/>
<xsl:import href="revo_kap.xsl"/>
<xsl:import href="revo_art.xsl"/>
<xsl:import href="revo_ref.xsl"/>
<xsl:import href="revo_dif.xsl"/>

<xsl:output method="text" encoding="utf-8"/>
<xsl:strip-space elements="trdgrp refgrp kap drv art dif snc"/>


<!-- kelkaj variabloj -->

<!-- xsl:variable name="smbdir">../smb</xsl:variable -->
<xsl:variable name="xmldir">../xml</xsl:variable> 
<!-- xsl:variable name="cssdir">../stl</xsl:variable -->
<!-- xsl:variable
name="redcgi">/cgi-bin/vokomail.pl?art=</xsl:variable -->
<xsl:variable name="bibliografio">../cfg/bibliogr.xml</xsl:variable>
<xsl:variable name="bibliogrhtml">../dok/bibliogr.xml</xsl:variable>
<xsl:variable name="revo">/home/revo/revo</xsl:variable>
<xsl:variable name="lingvoj_cfg" select="'../cfg/lingvoj.xml'"/>
<xsl:variable name="fakoj_cfg" select="'../cfg/fakoj.xml'"/>

<!-- ilustrite por HTML kun grafikoj ktp.
     simple por HTML tauga por konverto al simpla teksto -->
<xsl:variable name="aspekto" select="'simple'"/>


<!-- apartaj reguloj por bedic-formato -->

<xsl:template match="/">
  <xsl:apply-templates select="//art"/>
</xsl:template>

<xsl:template match="art">
  <xsl:choose>
    <xsl:when test="drv">
      <xsl:apply-templates select="drv"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="//drv" mode="extract"/>

      <xsl:apply-templates select="kap"/>#KAPO#
      {s}<xsl:apply-templates mode="ofc" select="kap/ofc|kap/fnt"/>
      <xsl:apply-templates select="node()[not(self::kap)]"/>{/s}#FINO#   
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="drv" mode="extract">
  <xsl:apply-templates select="kap"/>#KAPO#
  {s}<xsl:apply-templates mode="ofc" select="kap/ofc|kap/fnt"/>
  <xsl:apply-templates select="node()[not(self::kap)]"/>{/s}#FINO#
</xsl:template>

<xsl:template match="subart">
  {s}{ps}<xsl:number format="I."/>{/ps}
  <xsl:apply-templates/>{/s}
</xsl:template>

<xsl:template match="subart/drv">
  {ss}<xsl:apply-templates/>{/ss}
</xsl:template>

<xsl:template match="drv">
  <xsl:apply-templates select="kap"/>#KAPO#
  {s}<xsl:apply-templates mode="ofc" select="kap/ofc|kap/fnt"/>
  <xsl:apply-templates select="node()[not(self::kap)]"/>{/s}#FINO#
</xsl:template>

<xsl:template match="kap/ofc|kap/fnt"/>

<xsl:template mode="ofc" match="kap/ofc|kap/fnt">
  [<xsl:apply-templates/>]
</xsl:template>

<xsl:template match="snc">
  {ss}<xsl:apply-templates/>{/ss}
</xsl:template>

<xsl:template match="ekz">
  <xsl:text> </xsl:text>{ex}<xsl:apply-templates/>{/ex}
</xsl:template>

<xsl:template match="ref">
  {sa}<xsl:apply-templates/>{/sa}</xsl:template>

<xsl:template match="sup">
  <xsl:text>^(</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="sub">
  <xsl:text>_(</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="ofc|fnt">
  <xsl:text>[</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="fnt[bib|aut|vrk|lok]"/>
<!--  <xsl:text>[</xsl:text>
  <xsl:number level="any" count="fnt[bib|aut|vrk|lok]"/>
  <xsl:text>]</xsl:text>
</xsl:template -->

<xsl:template match="url">
  <xsl:apply-templates/>
  (<xsl:value-of select="@ref"/>)
</xsl:template>

<xsl:template match="em">
  {hw}<strong><xsl:apply-templates/></strong>{/hw}
</xsl:template>

<xsl:template name="admin"/>
<!--  <hr />
  <xsl:call-template name="redakto"/>
</xsl:template -->

<xsl:template match="rim"/>

</xsl:stylesheet>












