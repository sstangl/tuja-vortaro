<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->

<xsl:param name="verbose" select="false"/>

<xsl:output method="xml" encoding="utf-8"/>
<xsl:strip-space elements="t t1 k"/>

<xsl:variable name="ordigo">../cfg/ordigo.xml</xsl:variable>

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
     select="document($ordigo)/ordigo/lingvo[@lng=current()/@lng]/@kiel"/>

  <xsl:variable name="ordlng" select="($ordlng_1|@lng|'en')[1]"/>
  <xsl:variable name="chiuj_literoj"
      select="translate(normalize-space(document($ordigo)/ordigo/lingvo[@lng=$ordlng]),' ','')"/>

  <xsl:if test="string-length($chiuj_literoj) > 0">
  
    <trd-oj lng="{@lng}">
      <xsl:variable name="trdoj" select="."/>

      <xsl:for-each select="document($ordigo)/ordigo/lingvo[@lng=$ordlng]/l">
        <xsl:variable name="n" select="substring(concat(@n,'1'),1,1)"/>

        <!-- la sekva solvas la problemon 
             ekz. en la hispana kaj kimra, 
             kie ordighas "Ll" en alian grupon ol "L", 
             sed vortoj komencighantaj je "Ll" 
             ne aperu ankau sub "L" -->

        <xsl:variable name="minus" select="../l[@name=current()/@minus]"/> 
        <xsl:variable name="nminus"
           select="substring(concat(../l[@name=current()/@minus]/@n,'1'),1,1)"/>     

        <litero name="{@name}" min="{substring(.,1,1)}">
          <xsl:for-each
  	     select="$trdoj/v[contains(current(),substring(.,1,$n)) 
             and not(contains($minus,substring(.,1,$nminus)))]">

            <xsl:sort lang="{$ordlng}" select="concat(t,'|',t1)"/>
            <xsl:call-template name="v"/>

          </xsl:for-each>
        </litero>

      </xsl:for-each>

      <!-- traktu chiujn erojn, kiuj ne komencighas 
           per iu litero el la ordigoreguloj, 
          (FIXME: problemo povus esti, ke ghi ne kaptus 
           ekz. en la bretona vortojn kiel "cabdefg", 
           char "c" jam aperas en la grupoj "ch" kaj "c'h") -->

      <litero name="?">
        <xsl:for-each 
           select="$trdoj/v[not(contains($chiuj_literoj,substring(.,1,1)))]">

          <xsl:sort lang="{$ordlng}" select="t"/>
          <xsl:call-template name="v"/>

        </xsl:for-each>
      </litero>
    </trd-oj>
  </xsl:if>
</xsl:template>


<xsl:template match="kap-oj">
  <xsl:variable name="chiuj_literoj"
     select="translate(normalize-space(document($ordigo)/ordigo/lingvo[@lng='eo']),' ','')"/>
 
  <xsl:variable name="kapoj" select="."/>
 
  <xsl:if test="string-length($chiuj_literoj) > 0">
 
    <kap-oj lng="{@lng}">
      <xsl:for-each select="document($ordigo)/ordigo/lingvo[@lng='eo']/l">

        <litero name="{@name}" min="{substring(.,1,1)}">
          <xsl:for-each 
             select="$kapoj/v[contains(current(),substring(k,1,1))]">
 
            <xsl:sort lang="eo" select="k"/>
            <xsl:call-template name="v"/>
          </xsl:for-each>
        </litero>

      </xsl:for-each>

      <!-- traktu chiujn erojn, kiuj ne komencighas 
           per iu litero el la ordigoreguloj -->

      <litero name="?">
        <xsl:for-each 
           select="$kapoj/v[not(contains($chiuj_literoj,substring(k,1,1)))]">
 
          <xsl:sort lang="eo"/>
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

            <xsl:sort lang="eo" select="r"/> 
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

  <fako fak="{@fak}">
    <xsl:for-each select="v">
      <xsl:sort lang="eo"/>
      <xsl:call-template name="v-fak"/>
    </xsl:for-each>
  </fako>
</xsl:template>


<xsl:template match="bld-oj">
  <bld-oj>
    <xsl:for-each select="v">
      <xsl:sort lang="eo"/>
      <xsl:call-template name="v"/>
    </xsl:for-each>
  </bld-oj>
</xsl:template>


<xsl:template match="mlg-oj">
  <mlg-oj>
    <xsl:for-each select="v">
      <xsl:sort lang="eo"/>
      <xsl:call-template name="v"/>
    </xsl:for-each>
  </mlg-oj>
</xsl:template>


<xsl:template name="v">
  <v mrk="{@mrk}">
    <xsl:apply-templates select="k|t|t1"/>
  </v>
</xsl:template>

<xsl:template name="v-fak">
  <v mrk="{@mrk}">
    <xsl:apply-templates/>
  </v>
</xsl:template>

<xsl:template name="v-inv">
  <v mrk="{@mrk}">
    <k><xsl:apply-templates select="k1"/></k>
  </v>
</xsl:template>

<xsl:template match="k|r|t1|u">
  <xsl:copy><xsl:apply-templates/></xsl:copy>
</xsl:template>

<xsl:template match="t">
  <xsl:copy><xsl:value-of select="normalize-space(.)"/></xsl:copy>
</xsl:template>




</xsl:stylesheet>






