<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 199-2003 che Wolfram Diestel

reguloj por la prezentado de la fontindikoj

-->

<!-- nur mallongajn fontindikojn montru rekte en la teksto, che
     strukturitaj skribu nur numeron -->

<xsl:template match="fnt[bib|aut|vrk|lok]">

  <!-- la numero de la fontindiko -->
  <xsl:variable name="n">
    <xsl:number level="any" count="fnt[bib|aut|vrk|lok]"/>
  </xsl:variable>

  <!-- la fontindiko kun ligo al la referenco malsupre de la pagxo -->
  <span class="fnt">
    <a name="ekz_{$n}"></a>
    <xsl:text>[</xsl:text>
    <a class="{local-name((
                 ancestor::rim|
                 ancestor::ekz|
                 ancestor::bld|
                 self::node())[1])}" 
       href="#fnt_{$n}" title="vidu la fonton"><xsl:value-of select="$n"/>
    </a>
    <xsl:text>]</xsl:text>
  </span>
</xsl:template>


<xsl:template match="fnt">
  <sup class="{local-name()}"><xsl:value-of select="."/></sup>
</xsl:template>


<!-- la fontoreferencoj malsupre de la pagxoj -->

<xsl:template name="fontoj">
  <!-- se enestas strukturitaj fontoj, prezentu ilin en propra alineo -->
  <xsl:if test="//fnt[bib|aut|vrk|lok]">
    <hr />
    <div class="fontoj">
    <h2>fontoj</h2>
    <xsl:apply-templates select="//fnt[bib|aut|vrk|lok]" mode="fontoj"/>
    </div>
  </xsl:if>
</xsl:template>


<xsl:template match="fnt" mode="fontoj">

  <!-- la numero de la fontindiko -->
  <xsl:variable name="n">
    <xsl:number level="any" count="fnt[bib|aut|vrk|lok]"/>
  </xsl:variable>

  <!-- la fontindiko kun ligo al la loko de la fonto en la supra
  teksto -->
  <span class="fontoj">
    <a name="fnt_{$n}"></a>
    <a class="fnt" href="#ekz_{$n}" title="reiru al la ekzemplo">
      <xsl:value-of select="$n"/>
    </a>.
  
    <xsl:apply-templates mode="fontoj" select="bib|aut|vrk|lok"/>
  
  </span>
  <br />
</xsl:template>


<!-- bibliografia referenco -->

<xsl:template match="bib" mode="fontoj">

  <!-- prenu la informojn pri la bibliografiero el tiu dosiero -->
  <xsl:variable name="mll" select="."/>

  <xsl:choose>
    <xsl:when test="$aspekto='ilustrite'">
      <a class="fnt" href="{$bibliogrhtml}#{$mll}" target="indekso"
        title="al la bibliografio">
        <xsl:apply-templates mode="bibliogr"
        select="document($bibliografio)//vrk[@mll=$mll]"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates mode="bibliogr"
        select="document($bibliografio)//vrk[@mll=$mll]"/>
    </xsl:otherwise>
  </xsl:choose>

  <!-- interpunkcio -->
  <xsl:if test="following-sibling::lok">
    <xsl:text>, </xsl:text>
  </xsl:if>
  <xsl:if test="following-sibling::vrk">
    <xsl:text>, </xsl:text>
  </xsl:if>

</xsl:template>


<!-- verko en la bibliografiero -->

<xsl:template match="vrk" mode="bibliogr">
  <xsl:apply-templates mode="bibliogr" select="aut|trd|tit"/>
</xsl:template>


<!-- autoro en la bibliografiero -->

<xsl:template match="aut" mode="bibliogr">
  <xsl:apply-templates mode="bibliogr"/>
  <xsl:choose>
    <xsl:when test="following-sibling::trd">
      <xsl:text>, </xsl:text>
    </xsl:when>
    <xsl:when test="following-sibling::tit">
      <xsl:text>: </xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<!-- tradukinto en la bibliografiero -->

<xsl:template match="trd" mode="bibliogr">
  <xsl:text>trad. </xsl:text>
  <xsl:apply-templates mode="bibliogr"/>
  <xsl:if test="following-sibling::tit">
      <xsl:text>: </xsl:text>
  </xsl:if>
</xsl:template>


<!-- titolo en la bibliografiero -->

<xsl:template match="tit" mode="bibliogr">
  <xsl:apply-templates mode="bibliogr"/>
</xsl:template>


<!-- autoro de la fonto -->

<xsl:template match="aut" mode="fontoj">
  <xsl:apply-templates mode="fontoj"/>
  <xsl:if test="following-sibling::vrk|following-sibling::lok">
    <xsl:text>: </xsl:text>
  </xsl:if>
</xsl:template>

<!-- verko -->

<xsl:template match="vrk" mode="fontoj">
  <xsl:apply-templates mode="fontoj"/>
  <xsl:if test="following-sibling::lok">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:template>  


<!-- loko en la verko -->

<xsl:template match="lok" mode="fontoj">
  <xsl:apply-templates mode="fontoj"/>
</xsl:template>


<!-- referenco al la verko -->

<xsl:template match="url" mode="fontoj">
  <a class="fnturl" href="{@ref}" target="_new"
     title="al la verko">
  <xsl:apply-templates/>
  </a>
</xsl:template>


</xsl:stylesheet>












