<!DOCTYPE xsl:stylesheet 
[
<!ENTITY leftquot "``">
<!ENTITY rightquot "''">
<!ENTITY singleleftquot "`">
<!ENTITY singlerightquot "'">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
                version="1.0"
                extension-element-prefixes="xt">


<!-- (c) 1999-2003 che Wolfram Diestel 
     licenco GPL 2.0

tie chi trovighas nur variabloj por agordo kaj la
importkomandoj por la unuopaj dosieroj, kie enestas la
transform-reguloj

-->

<xsl:output method="text" version="4.0" encoding="utf-8"/>
<xsl:strip-space elements="art subart drv subdrv snc subsnc 
                           trdgrp refgrp kap"/>

<!-- kelkaj variabloj  -->

<xsl:variable name="smbdir">../smb</xsl:variable>
<xsl:variable name="xmldir">../xml</xsl:variable> 
<xsl:variable name="cssdir">../stl</xsl:variable>
<xsl:variable name="redcgi">/cgi-bin/vokomail.pl?art=</xsl:variable>
<xsl:variable name="bibliografio">../cfg/bibliogr.xml</xsl:variable>
<xsl:variable name="bibliogrhtml">../dok/bibliogr.html</xsl:variable>
<xsl:variable name="revo">/home/revo/revo</xsl:variable>
<xsl:variable name="lingvoj_cfg" select="'../cfg/lingvoj.xml'"/>

<xsl:template match="/">\ocp\TexUTF=inutf8
\InputTranslation currentfile \TexUTF
\documentclass[a4paper,12pt,twocolumn]{article}
\input unicode
\usepackage[esperanto]{babel}
%\usepackage[latin3]{inputenc}
%\usepackage[T2A]{fontenc}

\addtolength{\parskip}{.5\baselineskip}

\begin{document}
<xsl:apply-templates/>
\end{document}
</xsl:template>

<xsl:template match="prologo|epilogo"/>

<xsl:template match="art">
  <xsl:apply-templates/>
  <xsl:text>\par</xsl:text>
</xsl:template>

<xsl:template match="art/kap">
  <xsl:text>{\bfseries </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>} </xsl:text>
</xsl:template>

<xsl:template match="art/drv[position()>1]/kap">
  <xsl:text>{\bfseries </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>} </xsl:text>
</xsl:template>  

<xsl:template match="art/drv[1]/kap"/>

<xsl:template match="tld">
  <xsl:if test="@lit">
    <xsl:text>(</xsl:text>
    <xsl:value-of select="@lit"/>
    <xsl:text>)</xsl:text>
  </xsl:if>
  <xsl:text>$\sim$</xsl:text>
</xsl:template>


<xsl:template match="drv">
  <xsl:apply-templates select="kap|gra|uzo|fnt|dif|ref[@tip='dif']"/>
  <xsl:apply-templates select="subdrv|snc"/>
  <xsl:apply-templates
      select="node()[
        not(
          self::subdrv|
          self::snc|
          self::gra|
          self::uzo|
          self::fnt|
          self::kap|
          self::dif|
          self::mlg|
          self::ref
        [@tip='dif'])]"/>
</xsl:template>  

<xsl:template match="subdrv">
  <xsl:text>\textbf{</xsl:text>
  <xsl:number format="A."/>
  <xsl:text>}</xsl:text>
  <xsl:apply-templates select="dif|gra|uzo|fnt|ref[@tip='dif']"/>
  <xsl:apply-templates select="snc"/>
  <xsl:apply-templates
      select="node()[
       not(
         self::snc|
         self::gra|
         self::uzo|
         self::fnt|
         self::dif|
         self::ref
       [@tip='dif'])]"/>    
</xsl:template>



<xsl:template match="snc" mode="number-of-ref-snc">
  <xsl:number from="drv|subart" level="any" count="snc"/>
</xsl:template>

<xsl:template match="subsnc" mode="number-of-ref-snc">
  <xsl:number from="drv|subart" level="multiple" count="snc|subsnc"
    format="1.a"/>
</xsl:template>


<xsl:template match="snc">

  <xsl:choose>
    <xsl:when test="@ref">
      <xsl:text>{\bfseries </xsl:text>
      <xsl:apply-templates mode="number-of-ref-snc"
        select="id(@ref)"/>:
      <xsl:text>}</xsl:text>
    </xsl:when>
    <xsl:when test="count(ancestor::node()[self::drv or
             self::subart][1]//snc)>1">
      <xsl:text>{\bfseries </xsl:text>
      <xsl:number from="drv|subart" level="any" count="snc" format="1~"/>
      <xsl:text>}</xsl:text>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates select="gra|uzo|fnt|dif|ref[@tip='dif']"/>

  <xsl:apply-templates select="subsnc"/>

  <xsl:apply-templates
        select="node()[
          not(
           self::gra|
           self::uzo|
           self::fnt|
           self::dif|
           self::subsnc|
           self::ref
         [@tip='dif'])]"/>

  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="subsnc">
  <xsl:text>{\sffamily\bfseries </xsl:text>
  <xsl:number format="a)"/>
  <xsl:text>}</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="bld"/>


<xsl:template match="ekz">
  <xsl:text>{\itshape </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="trdgrp|trd"/>

<xsl:template match="dif/trdgrp|dif/trd">
  <xsl:text>{\itshape </xsl:text>  
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>

<!--
<xsl:template match="trdgrp|trd[@lng]">
  <xsl:if test="not(preceding-sibling::trdgrp|preceding-sibling::trd)">
    <xsl:text>

</xsl:text>
  </xsl:if>
  <xsl:text>{\itshape </xsl:text>  
  <xsl:value-of select="@lng"/>
  <xsl:text>}: </xsl:text>
  <xsl:choose>
    <xsl:when test="self::trdgrp">
      <xsl:apply-templates select="trd"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="position()=last()"> 
      <xsl:text>. </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>; </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="trdgrp/trd">
  <xsl:apply-templates/>
  <xsl:if test="position()!=last()"> 
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>
-->

<xsl:template match="uzo">
  <xsl:text>\textsf{\textsl{\small </xsl:text>  
  <xsl:apply-templates/>
  <xsl:text>}}~</xsl:text>
</xsl:template>

<xsl:template match="ofc">
  <xsl:text>$^{</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>}$</xsl:text>
</xsl:template>

<xsl:template match="fnt[bib]">
  <xsl:text>\,\raisebox{.5ex}{\upshape\tiny [</xsl:text>
  <xsl:apply-templates select="bib"/>
  <xsl:text>]}</xsl:text>
</xsl:template>

<xsl:template match="fnt[not(bib|vrk|url|lok)]">
  <xsl:text>\,\raisebox{.5ex}{\upshape\tiny </xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="fnt"/>

<xsl:template match="refgrp|ref">
  <xsl:choose>
    <xsl:when test="@tip='vid'">
      <xsl:text>$\rightarrow$</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='dif'">
      <xsl:text>$=$</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='sin'">
      <xsl:text>$\Rightarrow$</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='ant'">
      <xsl:text>$\not\Rightarrow$</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='super'">
      <xsl:text>$\nearrow$</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='sub'">
      <xsl:text>$\searrow$</xsl:text>
    </xsl:when>
    <xsl:when test="@tip='malprt'">
      <xsl:text>$\nearrow$</xsl:text>
    </xsl:when> 
    <xsl:when test="@tip='prt'">
      <xsl:text>$\searrow$</xsl:text>
    </xsl:when>
  </xsl:choose>
  <xsl:text>~{\itshape </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>} </xsl:text>
</xsl:template>

<xsl:template match="refgrp[@tip='hom']|ref[@tip='hom']"/>

<xsl:template match="dif/refgrp|dif/ref|ekz/refgrp|ekz/ref|
	      uzo/refgrp|uzo/ref|klr/refgrp|klr/ref">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="refgrp/ref">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="rim">
  <xsl:text> {\bfseries Rim.</xsl:text>
  <xsl:if test="@num"> 
    <xsl:text>~</xsl:text>
    <xsl:value-of select="@num"/>
  </xsl:if>
  <xsl:text>:</xsl:text>
  <xsl:text>}~</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="gra">
  <xsl:text>(</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>) </xsl:text>
</xsl:template>

<xsl:template match="sup">
  <xsl:text>\raisebox{.5ex}{\scriptsize </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="sub">
  <xsl:text>\raisebox{-.5ex}{\scriptsize </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="adm"/>



</xsl:stylesheet>











