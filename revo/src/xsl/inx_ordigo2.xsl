<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
>


<!-- (c) 2006-2012 che Wolfram Diestel
     licenco GPL 2.0
-->

<xsl:param name="verbose" select="'false'"/>
<xsl:param name="debug" select="'false'"/>

<xsl:output method="xml" encoding="utf-8" indent="yes"/>
<xsl:strip-space elements="t t1 k"/>

<!-- saxon:collation name="unicode"
class="net.sf.saxon.sort.CodepointCollator"/ -->

<xsl:include href="inx_ordigo2.inc"/>

<xsl:variable name="ordigo">../cfg/ordigo2.xml</xsl:variable>

<xsl:template match="/">
  <indekso>
    <xsl:apply-templates/>
  </indekso>
</xsl:template>


<xsl:template match="trd-oj">
  <xsl:if test="$verbose='true'">
    <xsl:message>progreso: traktas lingvon "<xsl:value-of
         select="@lng"/>"...</xsl:message>
  </xsl:if>

  <!-- lau reguloj de kiu lingvo ordigi? -->
  <xsl:variable name="ordlng_1" 
     select="document($ordigo)/ordigo/lingvo[string(@lng)=string(current()/@lng)]"/>

  <!-- xsl:variable name="ordlng" select="($ordlng_1|@lng)[1]"/ -->

  <xsl:variable name="ordlng">
    <xsl:choose>
      <xsl:when test="$ordlng_1/@kiel">
         <xsl:value-of select="$ordlng_1/@kiel"/>
      </xsl:when>
      <xsl:when test="$ordlng_1">
        <xsl:value-of select="@lng"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'la'"/> <!-- se ne aperas en ordigo.xml, uzu latinajn regulojn -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
      
  <xsl:if test="$debug='true'">
    <xsl:message>DBG: ordigi lau lingvo: "<xsl:value-of select="$ordlng"/>"...</xsl:message>
  </xsl:if>

  <xsl:variable name="chiuj_literoj"
      select="translate(normalize-space(document($ordigo)/ordigo/lingvo[@lng=$ordlng]),' ','')"/>

  <xsl:if test="$debug='true'">
    <xsl:message>DBG: literoj: "<xsl:value-of select="$chiuj_literoj"/>"...</xsl:message>
  </xsl:if>


  <xsl:if test="string-length($chiuj_literoj) > 0">
  
    <trd-oj lng="{@lng}" n="{@n}" p="{@p}">
      <xsl:variable name="trdoj" select="."/>

      <xsl:for-each select="document($ordigo)/ordigo/lingvo[string(@lng)=$ordlng]/l">
        <xsl:variable name="n" select="number(substring(concat(@n,'1'),1,1))"/>

        <!-- la sekva solvas la problemon 
             ekz. en la hispana kaj kimra, 
             kie ordighas "Ll" en alian grupon ol "L", 
             sed vortoj komencighantaj je "Ll" 
             ne aperu ankau sub "L" -->

        <xsl:variable name="minus" select="../l[@name=current()/@minus]"/> 
        <xsl:variable name="nminus"
           select="number(substring(concat(../l[@name=current()/@minus]/@n,'1'),1,1))"/>     

        <xsl:call-template name="trd-litero">
           <xsl:with-param name="trdoj" select="$trdoj/v[contains(current(),substring(t,1,$n)) 
             and not(contains($minus,substring(t,1,$nminus)))]"/>
           <xsl:with-param name="ordlng" select="$ordlng"/>
           <xsl:with-param name="lit-name" select="@name"/>
           <xsl:with-param name="lit-min" select="substring(.,1,$n)"/>
        </xsl:call-template>

      </xsl:for-each>

      <!-- traktu chiujn erojn, kiuj ne komencighas 
           per iu litero el la ordigoreguloj, 
          (FIXME: problemo povus esti, ke ghi ne kaptus 
           ekz. en la bretona vortojn kiel "cabdefg", 
           char "c" jam aperas en la grupoj "ch" kaj "c'h") -->


        <xsl:call-template name="trd-litero">
           <xsl:with-param name="trdoj"
              select="$trdoj/v[not(contains($chiuj_literoj,substring(t,1,1)))]"/>
           <xsl:with-param name="ordlng" select="$ordlng"/>
           <xsl:with-param name="lit-name" select="'0'"/>
           <xsl:with-param name="lit-min" select="'?'"/>
        </xsl:call-template>

    </trd-oj>
  </xsl:if>
</xsl:template>


<xsl:template match="mankoj">
  <xsl:copy-of select="."/>
</xsl:template>


<xsl:template match="kap-oj">
  <xsl:variable name="chiuj_literoj"
     select="translate(normalize-space(document($ordigo)/ordigo/lingvo[@lng='eo']),' ','')"/>
 
  <xsl:variable name="kapoj" select="."/>
 
  <xsl:if test="string-length($chiuj_literoj) > 0">
 
    <kap-oj lng="{@lng}">
      <xsl:apply-templates select="$kapoj/tez[v]"/>

      <xsl:for-each select="document($ordigo)/ordigo/lingvo[@lng='eo']/l">

        <litero name="{@name}" min="{substring(.,1,1)}">
          <xsl:for-each 
             select="$kapoj/v[contains(current(),substring(translate(k,'-(',''),1,1))]">
 
            <xsl:sort collation="eo" lang="eo" select="translate(k,'-( )','')"/>
            <xsl:call-template name="v"/>
          </xsl:for-each>
        </litero>

      </xsl:for-each>

      <!-- traktu chiujn erojn, kiuj ne komencighas 
           per iu litero el la ordigoreguloj -->

      <litero name="0" min="?">
        <xsl:for-each 
           select="$kapoj/v[not(contains($chiuj_literoj,substring(translate(k,'-(',''),1,1)))]">
 
          <xsl:sort collation="eo" lang="eo" select="k"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>
    </kap-oj>

  
    <!-- inversa indekso -->

    <inv lng="{@lng}">
      <xsl:for-each select="document($ordigo)/ordigo/lingvo[@lng='eo']/l">

        <litero name="{@name}" min="{substring(.,1,1)}">
          <xsl:for-each select="$kapoj/v[r and
             contains(current(),substring(r,1,1))]">

            <xsl:sort collation="eo" lang="eo" select="r"/> 
            <xsl:call-template name="v-inv"/>
          </xsl:for-each>
        </litero>

      </xsl:for-each>
    </inv>

  </xsl:if>
</xsl:template>


<xsl:template match="fako">
  <xsl:if test="$verbose='true'">
    <xsl:message>progreso: traktas fakon "<xsl:value-of
       select="@fak"/>"...</xsl:message>
  </xsl:if>

  <fako fak="{@fak}" n="{@n}">
    <xsl:apply-templates select="tez[v]"/>
    <xsl:for-each select="v">
      <xsl:sort collation="eo" lang="eo"/>
      <xsl:call-template name="v-fak"/>
    </xsl:for-each>
  </fako>
</xsl:template>


<xsl:template match="bld-oj">
  <bld-oj>
    <xsl:for-each select="v">
      <xsl:sort collation="eo" lang="eo" select="k"/>
      <xsl:call-template name="v"/>
    </xsl:for-each>
  </bld-oj>
</xsl:template>


<xsl:template match="mlg-oj">
  <mlg-oj>
    <xsl:for-each select="v">
      <xsl:sort collation="eo" lang="eo" select="t"/>
      <xsl:call-template name="v"/>
    </xsl:for-each>
  </mlg-oj>
</xsl:template>


<xsl:template match="tez">
  <tez>
    <xsl:for-each select="v">
      <xsl:sort collation="eo" lang="eo"/>
      <xsl:call-template name="v"/>
    </xsl:for-each>
  </tez>
</xsl:template>


<xsl:template match="stat|trd-snc">
  <xsl:copy-of select="."/>
</xsl:template>


<!-- xsl:template name="v">
  <v mrk="{@mrk}">
    <xsl:apply-templates select="k|t|t1"/>
  </v>
</xsl:template -->

<xsl:template name="v"><xsl:copy-of select="."/></xsl:template>


<!-- xsl:template name="v-fak">
  <v mrk="{@mrk}">
    <xsl:apply-templates/>
  </v>
</xsl:template -->

<xsl:template name="v-fak"><xsl:copy-of select="."/></xsl:template>


<xsl:template name="v-inv">
  <v mrk="{@mrk}">
    <k><xsl:apply-templates select="k1"/></k>
  </v>
</xsl:template>

<!-- xsl:template match="k|r|t1|u">
  <xsl:copy><xsl:apply-templates/></xsl:copy>
</xsl:template -->

<xsl:template match="k|r|t1|u|t"><xsl:copy-of select="."/></xsl:template>

<!-- xsl:template match="t">
  <xsl:copy><xsl:value-of select="normalize-space(.)"/></xsl:copy>
</xsl:template --> 




</xsl:transform>






