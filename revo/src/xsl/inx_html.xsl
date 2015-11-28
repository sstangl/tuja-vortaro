<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
>

<!-- xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect" -->


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->

<xsl:output method="@format@" encoding="utf-8"/>
<xsl:strip-space elements="t t1 k"/>

<xsl:param name="agordo-pado"/>

<xsl:variable name="lingvoj"><xsl:value-of select="concat($agordo-pado,'/lingvoj.xml')"/></xsl:variable>
<xsl:variable name="fakoj"><xsl:value-of select="concat($agordo-pado,'/fakoj.xml')"/></xsl:variable>
<xsl:variable name="enhavo"><xsl:value-of select="concat($agordo-pado,'/enhavo.xml')"/></xsl:variable>

<xsl:key name="trd-oj" match="//trd-oj/litero/v" use="concat(../../@lng,'-',../@name,'-',t)"/>

<xsl:variable name="root" select="/"/>

<xsl:template match="/">
  <xsl:text>XXXX</xsl:text> <!-- dosiero .tempo ne estu malplena -->

  <xsl:apply-templates select="document($enhavo)/enhavo/pagho"/>

  <xsl:call-template name="indeksoj">
    <xsl:with-param name="kap-oj" select="count(document($enhavo)/enhavo//KAP-OJ)"/>
    <xsl:with-param name="trd-oj" select="count(document($enhavo)/enhavo//TRD-OJ)"/>
    <xsl:with-param name="mankoj" select="count(document($enhavo)/enhavo//MANKOJ)"/>
    <xsl:with-param name="fakoj" select="count(document($enhavo)/enhavo//FAKOJ)"/>
    <xsl:with-param name="inv" select="count(document($enhavo)/enhavo//INV)"/>
    <xsl:with-param name="bld-oj" select="count(document($enhavo)/enhavo//BLD-OJ)"/>
    <xsl:with-param name="mlg-oj" select="count(document($enhavo)/enhavo//MLG-OJ)"/>
    <xsl:with-param name="stat" select="count(document($enhavo)/enhavo//STAT)"/>
  </xsl:call-template>

  <xsl:if test="count(document($enhavo)/enhavo//MANKOJ) &gt; 0">
    <xsl:for-each select="(document($enhavo)/enhavo//MANKOJ)[1]">
      <xsl:call-template name="MANKO-LISTOJ"/>
    </xsl:for-each>
  </xsl:if>
</xsl:template>


<xsl:template name="indeksoj">
  <xsl:param name="kap-oj"/>
  <xsl:param name="trd-oj"/>
  <xsl:param name="mankoj"/>
  <xsl:param name="fakoj"/>
  <xsl:param name="inv"/>
  <xsl:param name="bld-oj"/>
  <xsl:param name="mlg-oj"/>
  <xsl:param name="stat"/>

  <xsl:if test="$kap-oj > 0">
    <xsl:apply-templates select="//kap-oj"/>
  </xsl:if>

  <xsl:if test="$trd-oj > 0">
    <xsl:apply-templates select="//trd-oj"/>
  </xsl:if>

  <xsl:if test="$mankoj > 0">
    <xsl:apply-templates select="//mankoj"/>
  </xsl:if>

  <xsl:if test="$fakoj > 0">
    <xsl:apply-templates select="//fako"/>
  </xsl:if>

  <xsl:if test="$inv > 0">
    <xsl:apply-templates select="//inv"/>
  </xsl:if>

  <xsl:if test="$bld-oj > 0">
    <xsl:apply-templates select="//bld-oj"/>
  </xsl:if>

  <xsl:if test="$mlg-oj > 0">
    <xsl:apply-templates select="//mlg-oj"/>
  </xsl:if>

  <xsl:if test="$stat > 0">
    <xsl:apply-templates select="//stat"/>
  </xsl:if>
</xsl:template>


<xsl:template match="kap-oj|inv|trd-oj">
  <xsl:apply-templates select="litero[v]"/>
</xsl:template>


<xsl:template match="pagho">
  <!-- xsl:message>skribas al <xsl:value-of
  select="@dosiero"/></xsl:message -->
  <!-- redirect:write select="@dosiero" -->
  <xsl:result-document href="{@dosiero}" method="@format@" encoding="utf-8" indent="no">
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title><xsl:value-of select="concat(../@nometo,'-indekso: ',@titolo)"/></title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">
        <xsl:call-template name="menuo"/>
        <tr>
          <td colspan="{count(../pagho[not(@kashita='jes')])}" class="enhavo">
            <xsl:apply-templates/>
          </td>
        </tr>
      </table>
    </body>
  </html>
  <!-- /redirect:write -->
  </xsl:result-document>
</xsl:template>


<xsl:template match="sekcio">
  <h1><xsl:value-of select="@titolo"/></h1>
  <xsl:apply-templates/>
</xsl:template>

 
<xsl:template match="ero[@ref]">
  <p>
    <xsl:choose>
      <xsl:when test="@style">
       <xsl:attribute name="style"><xsl:value-of select="@style"/></xsl:attribute>
     </xsl:when>
     <xsl:otherwise>
         <xsl:attribute name="style">margin-top: 0; margin-bottom: 0</xsl:attribute>
     </xsl:otherwise>
    </xsl:choose>
    <a href="{@ref}">
      <xsl:if test="ancestor-or-self::node()/@kadro">
        <xsl:attribute name="target">
          <xsl:value-of select="(ancestor-or-self::node()/@kadro)[last()]"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="@titolo"/>
    </a>
  </p>
</xsl:template>


<xsl:template match="KAP-OJ">
  <p style="font-size: 120%"><b>
  <xsl:call-template name="literoj">
    <xsl:with-param name="context" select="$root//kap-oj"/>
    <xsl:with-param name="lit" select="'xxx'"/>
    <xsl:with-param name="pref" select="'kap_'"/>
  </xsl:call-template></b>
  </p>
</xsl:template>


<xsl:template match="TEZAURO">
  <xsl:for-each select="$root//kap-oj/tez">
    <xsl:call-template name="tezauro"/>
  </xsl:for-each>
</xsl:template>


<xsl:template name="tezauro">
  <xsl:for-each select="v">
    <a href="{concat('../tez/tz_',translate(@mrk,'.','_'),'.html')}" 
       style="font-weight: bold"><xsl:apply-templates/></a><br/>
  </xsl:for-each>
</xsl:template>


<xsl:template match="TRD-OJ[@lng]">
  <p>
  <xsl:for-each select="document($lingvoj)/lingvoj/lingvo[@kodo=current()/@lng]">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat('lx_',@kodo,'_',
              $root//trd-oj[@lng=current()/@kodo]/litero[v][1]/@name,
                      '.html')"/>
          </xsl:attribute>
          <b>
            <xsl:value-of select="."/>
          </b>
        </a>
  </xsl:for-each>
  </p>
</xsl:template>


<xsl:template match="TRD-OJ[@krom]">
  <p>
  <xsl:variable name="krom" select="@krom"/>

  <xsl:for-each select="document($lingvoj)/lingvoj/lingvo">
    <xsl:sort lang="eo"/>

    <xsl:if test="$root//trd-oj[@lng=current()/@kodo and @lng != $krom]">
      <xsl:choose>
        <xsl:when test="number($root//trd-oj[@lng=current()/@kodo]/@n) &gt; 1000">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat('lx_',@kodo,'_',
              $root//trd-oj[@lng=current()/@kodo]/litero[v][1]/@name,
                      '.html')"/>
          </xsl:attribute>
          <b>
            <xsl:value-of select="."/>
          </b>
        </a> <br/>
        </xsl:when>
        <xsl:when test="$root//trd-oj[@lng=current()/@kodo]">
        <a>
         <xsl:attribute name="href">
           <xsl:value-of select="concat('lx_',@kodo,'_',
              $root//trd-oj[@lng=current()/@kodo]/litero[v][1]/@name,
                      '.html')"/>
           </xsl:attribute>
           <xsl:value-of select="."/>
        </a> <br/>
        </xsl:when>
      </xsl:choose>
       
    </xsl:if>
  </xsl:for-each>
  </p>
</xsl:template>


<xsl:template match="MANKOJ">
  <a href="mankantaj.html"><xsl:value-of select="@titolo"/></a><br/>
</xsl:template>

<xsl:template name="MANKO-LISTOJ">
  <!-- redirect:write select="'mankantaj.html'" -->
  <xsl:result-document href="mankantaj.html" method="@format@" encoding="utf-8" indent="no">
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title><xsl:value-of select="concat(../@nometo,'-indekso: ',@titolo)"/></title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">

        <xsl:for-each select="ancestor::pagho">
          <xsl:call-template name="menuo"/>
        </xsl:for-each>

        <tr>
          <td colspan="{count(ancestor::pagho/../pagho[not(@kashita='jes')])}" class="enhavo">
            <h1>listoj de mankantaj tradukoj</h1>

            <xsl:for-each select="document($lingvoj)/lingvoj/lingvo">
              <xsl:sort lang="eo"/>

              <xsl:if test="$root//mankoj[@lng=current()/@kodo]">
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="concat('mx_',@kodo,'.html')"/>
                  </xsl:attribute>
                  <xsl:value-of select="."/>
                </a>
                <br/>
              </xsl:if>
            </xsl:for-each>

          </td>
        </tr>
      </table>
    </body>
  </html>
  <!-- /redirect:write -->
  </xsl:result-document>
</xsl:template>


<xsl:template match="FAKOJ">
    <xsl:for-each select="document($fakoj)/fakoj/fako">
              <xsl:sort lang="eo"/>

              <xsl:if test="$root//fako[@fak=current()/@kodo]">
                <img src="{@vinjeto}" alt="{@kodo}" border="0" align="middle"/>
                <xsl:text>&#xa0;</xsl:text>
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="concat('fx_',@kodo,'.html')"/>
                  </xsl:attribute>
                  <xsl:value-of select="."/>
                </a><br/>
             </xsl:if>
    </xsl:for-each>
</xsl:template>


<xsl:template match="MLG-OJ">
  <a href="mallong.html" style="{@style}"><xsl:value-of select="@titolo"/></a><br/>
</xsl:template>
 

<xsl:template match="BLD-OJ">
  <a href="bildoj.html" style="{@style}"><xsl:value-of select="@titolo"/></a><br/>
</xsl:template>


<xsl:template match="STAT">
  <p>
    <xsl:choose>
      <xsl:when test="@style">
       <xsl:attribute name="style"><xsl:value-of select="@style"/></xsl:attribute>
     </xsl:when>
     <xsl:otherwise>
         <xsl:attribute name="style">margin-top: 0; margin-bottom: 0</xsl:attribute>
     </xsl:otherwise>
    </xsl:choose>
    <a href="statistiko.html"><xsl:value-of select="@titolo"/></a><br/>
  </p>
</xsl:template>


<xsl:template match="INV">
  <a href="inv_{$root//inv/litero[v][1]/@name}.html" style="{@style}"><xsl:value-of select="@titolo"/></a><br/>
</xsl:template>


<xsl:template name="menuo">
  <xsl:variable name="aktiva" select="@dosiero"/>
  <tr>
    <xsl:for-each select="../pagho[not(@kashita='jes')]">
      <xsl:choose>
        <xsl:when test="@dosiero=$aktiva">
          <td class="aktiva">
            <a href="../inx/{@dosiero}">
              <xsl:value-of select="@titolo"/>
            </a>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td class="fona">
            <a href="../inx/{@dosiero}">
              <xsl:value-of select="@titolo"/>
            </a>
          </td>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>     
  </tr>
</xsl:template>


<xsl:template name="menuo-eo">
  <xsl:for-each select="document($enhavo)//pagho[.//KAP-OJ][1]"> 
    <xsl:call-template name="menuo"/>
  </xsl:for-each>
</xsl:template>


<xsl:template name="menuo-lng">
  <xsl:for-each select="document($enhavo)//pagho[.//TRD-OJ][1]"> 
    <xsl:call-template name="menuo"/>
  </xsl:for-each>
</xsl:template>


<xsl:template name="menuo-fak">
  <xsl:for-each select="document($enhavo)//pagho[.//FAKOJ][1]"> 
    <xsl:call-template name="menuo"/>
  </xsl:for-each>
</xsl:template>


<xsl:template name="menuo-ktp">
  <xsl:for-each select="document($enhavo)//pagho[.//BLD-OJ][1]"> 
    <xsl:call-template name="menuo"/>
  </xsl:for-each>
</xsl:template>


<!-- kreas unuopan indeksdosieron per "redirect" -->
<xsl:template match="litero|fako|bld-oj|mlg-oj|stat|mankoj">

   <!-- konstruu dosiernomon -->

   <xsl:variable name="lit" select="@name"/>
   <xsl:variable name="pref">
     <xsl:choose>
       <xsl:when test="parent::node()[self::kap-oj]">
         <xsl:text>kap_</xsl:text>
       </xsl:when>
       <xsl:when test="parent::node()[self::trd-oj]">
         <xsl:value-of select="concat('lx_',../@lng,'_')"/>
       </xsl:when>
       <xsl:when test="self::mankoj">
         <xsl:value-of select="concat('mx_',@lng)"/>
       </xsl:when>
       <xsl:when test="self::fako">
         <xsl:value-of select="concat('fx_',@fak)"/>
       </xsl:when>
       <xsl:when test="self::bld-oj">
         <xsl:text>bildoj</xsl:text>
       </xsl:when>
       <xsl:when test="self::mlg-oj">
         <xsl:text>mallong</xsl:text>
       </xsl:when>
       <xsl:when test="parent::node()[self::inv]">
         <xsl:text>inv_</xsl:text>
       </xsl:when>
       <xsl:when test="self::stat">
         <xsl:text>statistiko</xsl:text>
       </xsl:when>
    </xsl:choose>
  </xsl:variable>

  <!-- redirect:write select="concat($pref,$lit,'.html')" -->
  <xsl:result-document href="{concat($pref,$lit,'.html')}" method="@format@" encoding="utf-8" indent="no">

  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
          <xsl:choose>
             <xsl:when test="parent::node()[self::kap-oj]">
       <title>esperanta indekso</title>
             </xsl:when>
             <xsl:when test="parent::node()[self::trd-oj]">
       <title><xsl:value-of 
                   select="document($lingvoj)/lingvoj/lingvo[@kodo=current()/../@lng]"/> 
              <xsl:text> indekso</xsl:text>
       </title>
             </xsl:when>
             <xsl:when test="self::mankoj">
       <title><xsl:text>netradukitaj sencoj de la lingvo </xsl:text><xsl:value-of 
                   select="document($lingvoj)/lingvoj/lingvo[@kodo=current()/@lng]"/> 
       </title>
             </xsl:when>
             <xsl:when test="self::fako">
       <title>fakindekso: <xsl:value-of 
            select="document($fakoj)/fakoj/fako[@kodo=../@fak]"/>
       </title>
             </xsl:when>
             <xsl:when test="parent::node()[self::inv]">
       <title>inversa indekso</title>
            </xsl:when>
            <xsl:when test="self::bld-oj">
       <title>bildo-indekso</title>
            </xsl:when>
            <xsl:when test="self::mlg-oj">
       <title>mallongigo-indekso</title>
            </xsl:when>
            <xsl:when test="self::stat">
       <title>statistiko</title>
            </xsl:when>
          </xsl:choose>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">
        <xsl:choose>
          <xsl:when test="parent::node()[self::kap-oj]">
            <xsl:call-template name="menuo-eo"/>
          </xsl:when>
          <xsl:when test="parent::node()[self::trd-oj]">
            <xsl:call-template name="menuo-lng"/>
          </xsl:when>
          <xsl:when test="self::fako">
            <xsl:call-template name="menuo-fak"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="menuo-ktp"/>
          </xsl:otherwise>
        </xsl:choose>
        <tr>
          <td colspan="4" class="enhavo">

          <!-- titolo -->

          <xsl:choose>
            <xsl:when test="self::fako">

<!--              <b class="elektita">alfabete</b><xsl:text> </xsl:text>
              <a href="../tez/fxs_{@fak}.html">strukture</a><xsl:text> </xsl:text> -->

              <h1><xsl:value-of 
                  select="document($fakoj)/fakoj/fako[@kodo=current()/@fak]"/>
              </h1>
            </xsl:when>
            <xsl:when test="self::mankoj">
              <h1>
                <xsl:choose>
                   <xsl:when test="../trd-snc/@p - ../trd-oj[@lng=current()/@lng]/@p = count(v)">
                      <xsl:text>La </xsl:text>
                      <xsl:value-of select="count(v)"/>
                   </xsl:when>
                   <xsl:otherwise>
                     <xsl:value-of select="count(v)"/>
                     <xsl:text> el </xsl:text>
                     <xsl:value-of select="../trd-snc/@p - ../trd-oj[@lng=current()/@lng]/@p"/> 
                   </xsl:otherwise>
                </xsl:choose>
                <xsl:text> netradukitaj sencoj de la lingvo </xsl:text>
                <xsl:value-of 
                       select="document($lingvoj)/lingvoj/lingvo[@kodo=current()/@lng]"/>
              </h1>
            </xsl:when>
            <xsl:when test="self::bld-oj">
              <h1>bildoj</h1>
            </xsl:when>
            <xsl:when test="self::mlg-oj">
              <h1>mallongigoj</h1>
            </xsl:when>
            <xsl:when test="self::stat">
              <h1>statistiko</h1>
            </xsl:when>
            <xsl:otherwise>

              <xsl:call-template name="literoj">
                 <xsl:with-param name="context" select=".."/>
                 <xsl:with-param name="lit" select="$lit"/>
                 <xsl:with-param name="pref" select="$pref"/>
              </xsl:call-template>

              <h1>
                <xsl:choose>
                   <xsl:when test="parent::node()[self::inv]">
                     <xsl:text>inversa </xsl:text>
                   </xsl:when>
                   <xsl:otherwise>
                     <xsl:value-of 
                       select="document($lingvoj)/lingvoj/lingvo[@kodo=current()/../@lng]"/>
                     <xsl:text> </xsl:text>
                   </xsl:otherwise>
                 </xsl:choose>
                 <xsl:value-of select="@min"/>
                 <xsl:text>...</xsl:text>
               </h1>
            </xsl:otherwise>

         </xsl:choose>

         <!-- enhavo -->

         <xsl:choose>
     
           <!-- mallongigoj -->
           <xsl:when test="self::mlg-oj">
             <dl compact="compact">
               <xsl:apply-templates/>
             </dl>
           </xsl:when>

           <!-- bildoj -->
           <xsl:when test="self::bld-oj">
             <dl>
               <xsl:apply-templates/>
             </dl>
           </xsl:when>

           <!-- statistiko -->
           <xsl:when test="self::stat">

              <h2>kapvortoj k.a.</h2>
              <table>
                <xsl:for-each select="ero">
                  <tr>
                    <td><xsl:value-of select="@t"/><xsl:text>: </xsl:text></td>
                    <td align="right"><xsl:value-of select="@n"/></td>
                  </tr>
                </xsl:for-each>
              </table>

              <h2>tradukoj</h2>
              <table>
                <xsl:variable name="trd-snc" select="../trd-snc/@p"/>
                <xsl:for-each select="../trd-oj">
                  <xsl:sort select="@n" data-type="number" order="descending"/>
                  <xsl:sort select="@lng"/>
                  <tr>
                    <xsl:for-each select="document($lingvoj)/lingvoj/lingvo[@kodo=current()/@lng]">
                      <td><xsl:value-of select="."/><xsl:text>: </xsl:text></td>
                    </xsl:for-each>
                    <td align="right"><xsl:value-of select="@n"/></td>
                    <td align="right"><xsl:text>~</xsl:text>
                      <xsl:value-of select="round(@p * 1000 div $trd-snc) div 10"/>
                      <xsl:text>%</xsl:text>
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
              (la procentoj rezultas el nombro de tradukitaj sencoj je la nombro de 
               tradukendaj sencoj)

              <h2>fakoj</h2>
              <table>
                <xsl:for-each select="../fako">
                  <xsl:sort select="@n" data-type="number" order="descending"/>
                  <xsl:sort select="@fak"/>
                  <tr>
                    <xsl:for-each select="document($fakoj)/fakoj/fako[@kodo=current()/@fak]">
                      <td><img src="{@vinjeto}" alt="{@fak}" border="0" align="middle"/></td>
                      <td><xsl:value-of select="."/><xsl:text>: </xsl:text></td>
                    </xsl:for-each>
                    <td align="right"><xsl:value-of select="@n"/></td>
                  </tr>
                </xsl:for-each>
              </table>

           </xsl:when>


           <!-- fakindekso -->
           <xsl:when test="self::fako">

             <xsl:for-each select="tez">
               <h2>&#x0109;efaj nocioj</h2>
               <p>
                 <xsl:call-template name="tezauro"/>
               </p>
             </xsl:for-each>

             <h2>nocioj alfabete</h2>
             <xsl:apply-templates select="v"/>
           </xsl:when>

           <!-- litero ene de trd-oj -->
           <xsl:when test="parent::trd-oj">
             <xsl:choose>
               <xsl:when test="../@lng = 'ar' or
                               ../@lng = 'fa' or
                               ../@lng = 'he'">
                 <div dir="rtl">
                   <xsl:apply-templates/>
                 </div>
               </xsl:when>
               <xsl:otherwise>
                 <xsl:apply-templates/>
               </xsl:otherwise>
             </xsl:choose>
           </xsl:when>

           <!-- aliaj indeksoj -->
           <xsl:otherwise>
             <xsl:apply-templates/>
           </xsl:otherwise>
        </xsl:choose>

      </td>
        </tr>
      </table>
    </body>
  </html>
  <!-- /redirect:write -->
  </xsl:result-document>

</xsl:template>


<xsl:template match="kap-oj/litero/v">
  <xsl:choose>
    <xsl:when test="contains(@mrk,'.')">
      <a href="../art/{substring-before(@mrk,'.')}.html#{@mrk}" 
        target="precipa">
        <xsl:apply-templates select="k"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <a href="../art/{@mrk}.html" target="precipa">
        <b><xsl:apply-templates select="k"/></b>
      </a>
    </xsl:otherwise>
  </xsl:choose>
  <br/>
</xsl:template>


<!-- xsl:template match="trd-oj/litero/v">
  <xsl:choose>
    <xsl:when test="t1">
      <xsl:apply-templates select="t1"/><xsl:text>: </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="t"/><xsl:text>: </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <a target="precipa">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(@mrk,'.')">
          <xsl:value-of select="concat('../art/',
             substring-before(@mrk,'.'),'.html#',@mrk)"/> 
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates select="k"/>
  </a>
  <br/>
</xsl:template -->

<xsl:template match="trd-oj/litero/v">

  <!-- Cxu temas pri araba, persa aux hebrea traduko? -->
  <xsl:variable name="trd-rtl" 
                select="../../@lng = 'ar' or
                        ../../@lng = 'fa' or
                        ../../@lng = 'he'"/>

  <xsl:choose>

    <!-- se key('trd-oj') enhavas nur unu tian eron montru kiel "t: k" -->
    <xsl:when test="count(key('trd-oj',concat(../../@lng,'-',../@name,'-',t)))=1">

      <xsl:choose>
        <xsl:when test="t1">
          <xsl:apply-templates select="t1"/><xsl:text>: </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="t"/><xsl:text>: </xsl:text>
        </xsl:otherwise>
      </xsl:choose>

      <a target="precipa">
        <xsl:if test="$trd-rtl">
          <xsl:attribute name="dir">ltr</xsl:attribute>
        </xsl:if>
        <xsl:attribute name="href">
          <xsl:choose>
            <xsl:when test="contains(@mrk,'.')">
              <xsl:value-of select="concat('../art/',
                substring-before(@mrk,'.'),'.html#',@mrk)"/> 
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates select="k"/>
      </a>
      <br/>

    </xsl:when>

    <!-- aliokaze montru kiel "t: k, k, ...; t1: k; t1: k; ... " au simile --> 
    <xsl:when test="count(.|key('trd-oj',concat(../../@lng,'-',../@name,'-',t))[1])=1">

      <xsl:apply-templates select="t"/><xsl:text>: </xsl:text>
     
      <xsl:for-each select="key('trd-oj',concat(../../@lng,'-',../@name,'-',t))[not(t1)]">
        <xsl:sort lang="eo" select="k"/> 
     
        <xsl:if test="not(following-sibling::v[k=current()/k and t=current()/t and not(t1)])">
          <a target="precipa">
            <xsl:if test="$trd-rtl">
              <xsl:attribute name="dir">ltr</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="href">
              <xsl:choose>
                <xsl:when test="contains(@mrk,'.')">
                  <xsl:value-of select="concat('../art/',
                    substring-before(@mrk,'.'),'.html#',@mrk)"/> 
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="k"/>
          </a>
          <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
        </xsl:if>
      </xsl:for-each>
      <br/>

      <xsl:for-each select="key('trd-oj',concat(../../@lng,'-',../@name,'-',t))[t1]">
        <xsl:sort lang="eo" select="k"/> 

        <xsl:text>&#xa0;&#xa0;&#xa0;</xsl:text>
        <xsl:apply-templates select="t1"/><xsl:text>: </xsl:text>
        <a target="precipa">
          <xsl:if test="$trd-rtl">
            <xsl:attribute name="dir">ltr</xsl:attribute>
          </xsl:if>
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="contains(@mrk,'.')">
                <xsl:value-of select="concat('../art/',
                  substring-before(@mrk,'.'),'.html#',@mrk)"/> 
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates select="k"/>
        </a><br/>
      </xsl:for-each>

    </xsl:when>

  </xsl:choose>
</xsl:template>


<xsl:template match="u">
  <u><xsl:apply-templates/></u>
</xsl:template>


<xsl:template match="mankoj/v">
  <xsl:number/>
  <xsl:text>: </xsl:text>
  <a target="precipa">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(@mrk,'.')">
          <xsl:value-of select="concat('../art/',
             substring-before(@mrk,'.'),'.html#',@mrk)"/> 
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates/>
    <xsl:if test="@n">
      <xsl:text> </xsl:text>
      <sup><i>
        <xsl:value-of select="@n"/>
      </i></sup>
    </xsl:if>
  </a>
  <br/>
</xsl:template>


<xsl:template match="inv/litero/v">
  <a target="precipa">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(@mrk,'.')">
          <xsl:value-of select="concat('../art/',
             substring-before(@mrk,'.'),'.html#',@mrk)"/> 
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:value-of select="k"/>
  </a>
  <br/>
</xsl:template>


<xsl:template match="fako/v">
  <a target="precipa">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(@mrk,'.')">
          <xsl:value-of select="concat('../art/',
             substring-before(@mrk,'.'),'.html#',@mrk)"/> 
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates/>
  </a>
  <br/>
</xsl:template>


<xsl:template match="mlg-oj/v">
  <dt><b><xsl:apply-templates select="t"/></b></dt>
  <dd>
  <a target="precipa">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(@mrk,'.')">
          <xsl:value-of select="concat('../art/',
             substring-before(@mrk,'.'),'.html#',@mrk)"/> 
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates select="k"/>
  </a>
  </dd>
</xsl:template>

<xsl:template match="bld-oj/v">
  <dt><a target="precipa">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(@mrk,'.')">
          <xsl:value-of select="concat('../art/',
             substring-before(@mrk,'.'),'.html#',@mrk)"/> 
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('../art/',@mrk,'.html')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates select="k"/>
  </a></dt>
  <dd><xsl:apply-templates select="t"/></dd>
</xsl:template>


<!-- xsl:template match="k">
  <xsl:value-of select="translate(.,'/','')"/>
</xsl:template -->



<xsl:template name="literoj">
  <xsl:param name="context"/>
  <xsl:param name="lit"/>
  <xsl:param name="pref"/>

<!-- <xsl:message><xsl:value-of select="$context/@lng"/></xsl:message> -->

  <xsl:variable name="lng" select="string($context/@lng)"/>
  <xsl:for-each select="$context/litero[v]">

    <xsl:choose>
      <xsl:when test="$lit=@name">
        <b class="elektita">
          <xsl:value-of select="@min"/>
        </b><xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <a href="{$pref}{@name}.html">
          <xsl:value-of select="@min"/>
        </a><xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:for-each>
</xsl:template>


<!-- /xsl:stylesheet -->
</xsl:transform>









