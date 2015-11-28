<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
>

<!-- faras la chefajn paghojn index.html kaj titolo.html el voko/cfg/enhavo.xml -->

<!-- xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect" -->


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<!-- necesas indent=no, cxar aliokaze cxe la elektokesto
aperas "c _x_" anstata "c_x_" -->
<xsl:output method="xhtml" encoding="utf-8" indent="no"/>
<xsl:variable name="inx" select="'inx/'"/>


<!-- kadraro, t.e. index.html -->
<xsl:template match="/enhavo">

  <html>
    <head>
      <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
      <title><xsl:value-of select="@nomo"/></title>
      <xsl:if test="@piktogramo">
         <link rel="SHORTCUT ICON" href="{@piktogramo}"/>
      </xsl:if>
      <xsl:for-each select="bonveno/sercho[@ref]">
        <link rel="search" type="application/opensearchdescription+xml" 
           title="{@titolo}" href="{@ref}"/>
      </xsl:for-each>
      <xsl:for-each select="bonveno/resumo[@ref]">
        <link rel="alternate" type="application/rss+xml" 
           title="{@titolo}" href="{@ref}"/>
      </xsl:for-each>
    </head>

    <frameset cols="33%,*">
      <frame name="indekso" src="{concat($inx,pagho[not(kashita='jes')][1]/@dosiero)}"/>
      <frame scrolling="yes" name="precipa" src="titolo.html"/>

      <noframes>
        <h1><xsl:value-of select="@nomo"/></h1>
        <xsl:for-each select="pagho">
          <a href="{concat($inx,@dosiero)}"><xsl:value-of select="@titolo"/></a><br/>
        </xsl:for-each>
      </noframes>
    </frameset>
  </html>

  <xsl:call-template name="titolo"/>
</xsl:template>


<!-- bonvenopagho, t.e. titolo.html -->
<xsl:template name="titolo">
  <xsl:result-document href="titolo.html" method="xhtml" encoding="utf-8">
  <!-- redirect:write select="'titolo.html'" -->
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title><xsl:value-of select="@nomo"/></title>
      <link title="artikolo-stilo" type="text/css" 
            rel="stylesheet" href="stl/artikolo.css"/>

      <xsl:if test="bonveno/sercho">
        <xsl:call-template name="script-literoj"/>
      </xsl:if>
    </head>
    <body>
      <xsl:if test="bonveno/sercho">
        <xsl:attribute name="onLoad">
  	  <xsl:text>document.f.sercxata.focus();</xsl:text>
        </xsl:attribute>
      </xsl:if>

      <h1 align="center" style="color:black; font-size: xx-large"><xsl:value-of select="@nomo"/></h1>

      <xsl:apply-templates select="bonveno/(alineo|bildo|sercho)"/>

    </body>
  </html>
  <!-- /redirect:write -->
  </xsl:result-document>

  <xsl:if test="bonveno//serchaldono">
    <xsl:call-template name="javoskript-averto"/>
  </xsl:if>
</xsl:template>

<!-- jsaverto.html -->
<xsl:template name="javoskript-averto">
  <xsl:result-document href="jsaverto.html" method="xhtml" encoding="utf-8">
  <!-- redirect:write select="'jsaverto.html'" -->
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title>Javoskript-Averto</title>
      <link title="artikolo-stilo" type="text/css" 
            rel="stylesheet" href="stl/artikolo.css"/>
    </head>
    <body>
      <h1 align="center" style="color:black; font-size: xx-large">Javoskript-Averto</h1>

      <xsl:apply-templates select="bonveno/javoskriptaverto"/>

    </body>
  </html>
  <!-- /redirect:write -->
  </xsl:result-document>
</xsl:template>


<xsl:template name="script-literoj">
  <script type="text/javascript">
  <xsl:comment>
    function xAlUtf8(t,el) {
     if (document.getElementById("x").checked) {
        t = t.replace(/c[xX]/g, "\u0109");
        t = t.replace(/g[xX]/g, "\u011d");
        t = t.replace(/h[xX]/g, "\u0125");
        t = t.replace(/j[xX]/g, "\u0135");
        t = t.replace(/s[xX]/g, "\u015d");
        t = t.replace(/u[xX]/g, "\u016d");
        t = t.replace(/C[xX]/g, "\u0108");
        t = t.replace(/G[xX]/g, "\u011c");
        t = t.replace(/H[xX]/g, "\u0124");
        t = t.replace(/J[xX]/g, "\u0134");
        t = t.replace(/S[xX]/g, "\u015c");
        t = t.replace(/U[xX]/g, "\u016c");
        if (t != document.getElementById(el).value) {
           document.getElementById(el).value = t;
        }
     }
   }
//</xsl:comment>
  </script>
</xsl:template>


<xsl:template match="sercho[@tipo='google']">
   <div align="center">
     <form method="get" action="http://www.google.be/search" style="text-align: center" target="_parent">
     <p>
       Per <img src="http://www.google.com/logos/Logo_25wht.gif" border="0" alt="Google" align="absmiddle"/>
       <input type="text" id="q" name="q" onKeyUp="xAlUtf8(this.value,'q')" size="31" maxlength="255" value=""/>
       <input type="submit" name="btnG" value="trovu"/>
      </p>
     <input type="hidden" name="hl" value="eo"/>
     <input type="hidden" name="ie" value="utf-8"/>
     <input type="hidden" name="oe" value="utf-8"/>
     <input type="hidden" name="sitesearch" value="reta-vortaro.de"/>
     <input type="hidden" name="hq" value="inurl:revo/art"/>
     </form>
   </div>
</xsl:template>

<xsl:template match="sercho[@tipo='anst']">
   <div align="center">
   <p>
       <input type="checkbox" name="x" id="x" onClick="xAlUtf8(document.f.sercxata.value,'sercxata')" checked="checked"/>
       <xsl:text>anstata&#x016d;igu&#xa0;</xsl:text> c<u>x</u>
       <xsl:text>,&#xa0;gx,&#xa0;...,&#xa0;ux</xsl:text>
   </p>
   </div>
</xsl:template>

<xsl:template match="sercho[@tipo='revo']">
   <div align="center">

     <form method="post" action='/cgi-bin/sercxu.pl' target='indekso' name="f">
        <p>
	Ser&#265;o en ReVo:
	<input type='text' id='sercxata' name='sercxata' size="31" maxlength="255" 
	onKeyUp="xAlUtf8(this.value,'sercxata')"/>
	<input type='submit' value='trovu'/>
	</p>
        <p>
       <input type="checkbox" name="x" id="x" onClick="xAlUtf8(document.f.sercxata.value,'sercxata')" checked="checked"/>
         <xsl:text>anstata&#x016d;igu&#xa0;</xsl:text> c<u>x</u>
         <xsl:text>,&#xa0;gx,&#xa0;...,&#xa0;ux</xsl:text>
        </p>
     </form>
   </div>
</xsl:template>

<xsl:template match="serchaldono">
   <a href="jsaverto.html">
     <xsl:attribute name="onclick">
        <xsl:text>window.external.AddSearchProvider('</xsl:text>
        <xsl:value-of select="ancestor::bonveno/sercho[@tipo=current()/@tipo]/@ref"/>
        <xsl:text>');return false;</xsl:text>
     </xsl:attribute>
     <xsl:apply-templates/>
   </a>
</xsl:template>

<xsl:template match="alineo">
  <p>
    <xsl:attribute name="style">
      <xsl:text>width: 80%; margin-left: 10%;</xsl:text>
      <xsl:value-of select="@style"/>
    </xsl:attribute>
    <xsl:apply-templates/>
  </p>
</xsl:template>


<xsl:template match="bildo">
  <div align="center">
  <img src="{@loko}" align="center" alt="titolbildo"/>
  </div>
</xsl:template>


<xsl:template match="url">
  <a href="{@ref}">
    <xsl:if test="@kadro">
      <xsl:attribute name="target">
        <xsl:value-of select="@kadro"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/></a>
</xsl:template>



<!-- /xsl:stylesheet -->
</xsl:transform>



