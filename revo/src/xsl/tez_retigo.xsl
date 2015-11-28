<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<xsl:output method="xml" encoding="utf-8" indent="yes"/>
<xsl:strip-space elements="kap"/>

<xsl:key name="retro" match="ref" use="@cel"/>


<xsl:template match="/">
  <tez>
  <xsl:apply-templates/>
  </tez>
</xsl:template>

<xsl:template match="art">
  <xsl:apply-templates select="subart|drv|snc"/>
</xsl:template>

<xsl:template match="subart|drv|subdrv">
  <xsl:apply-templates select="drv|subdrv|snc|subsnc"/>
</xsl:template>


<xsl:template match="drv[count(snc)=1]">
  <!-- kreu ununuran nodon por derivajhoj kun nur unu senco -->
  <xsl:if test=".//tezrad or .//ref or key('retro',@mrk) or key('retro',snc/@mrk)">
    <nod mrk="{@mrk}">
      <xsl:if test="snc/@mrk">
        <xsl:attribute name="mrk2">
          <xsl:value-of select="snc/@mrk"/>
        </xsl:attribute>
      </xsl:if>
      <k>
        <xsl:apply-templates select="ancestor-or-self::node()[self::art or self::drv][kap][1]/kap"/>
      </k>

      <xsl:copy-of select=".//tezrad"/>
      <xsl:copy-of select=".//uzo"/>

      <xsl:call-template name="super2"/>
      <xsl:call-template name="sub2"/>
      <xsl:call-template name="dif2"/>
      <xsl:call-template name="sin2"/>
      <xsl:call-template name="vid2"/>
      <xsl:call-template name="ant2"/>
      <xsl:call-template name="malprt2"/>
      <xsl:call-template name="prt2"/>
      <xsl:call-template name="ekz2"/>
      <xsl:call-template name="lst2"/>
    </nod>
  </xsl:if>
</xsl:template>


<xsl:template match="drv[count(snc)!=1]|snc|subsnc">
  <xsl:if test="tezrad or ref or key('retro',@mrk)">

    <!-- kreu novan nodon -->
    <nod>
      <xsl:attribute name="mrk">
        <!-- xsl:choose>
          <xsl:when test="@mrk">
            <xsl:value-of select="@mrk"/>
          </xsl:when>

          <xsl:otherwise>
            <xsl:value-of select="ancestor::node()[@mrk][1]/@mrk"/><xsl:text>.</xsl:text>
            <xsl:number from="drv|subart" level="multiple" count="snc|subsnc" format="1.a"/>
          </xsl:otherwise>
        </xsl:choose -->
        <xsl:call-template name="tez-mrk-n"/>
      </xsl:attribute>
      <k>
        <xsl:if test="count(../snc)+count(../subsnc) &gt; 1">
          <xsl:attribute name="n">
            <xsl:number from="drv|subart" level="multiple" count="snc|subsnc" format="1.a"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates select="ancestor-or-self::node()[self::art or self::drv][kap][1]/kap"/>
      </k>

      <xsl:copy-of select="tezrad"/>
      <xsl:copy-of select="uzo"/>

      <xsl:call-template name="super"/>
      <xsl:call-template name="sub"/>
      <xsl:call-template name="dif"/>
      <xsl:call-template name="sin"/>
      <xsl:call-template name="vid"/>
      <xsl:call-template name="ant"/>
      <xsl:call-template name="malprt"/>
      <xsl:call-template name="prt"/>
      <xsl:call-template name="ekz"/>
      <xsl:call-template name="lst"/>
    </nod>
  </xsl:if>
  <xsl:apply-templates select="snc|subsnc"/>
</xsl:template>


<xsl:template name="tez-mrk-n">
   <xsl:choose>
      <xsl:when test="@mrk">
         <xsl:value-of select="@mrk"/>
      </xsl:when>

      <xsl:otherwise>
         <xsl:value-of select="ancestor::node()[@mrk][1]/@mrk"/><xsl:text>.</xsl:text>
         <xsl:number from="drv|subart" level="multiple" count="snc|subsnc" format="1.a"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<!-- xsl:template match="snc|subsnc"/ --> <!-- ignoru sen @mrk -->


<xsl:template match="kap">
   <xsl:variable name="kap"><xsl:apply-templates select="text()|rad|tld"/></xsl:variable>
   <xsl:value-of select="translate(normalize-space($kap),'/,','')"/>
</xsl:template>


<xsl:template match="tld">
  <xsl:choose>

    <xsl:when test="@lit">
      <xsl:value-of select="concat(@lit,substring(ancestor::art/kap/rad,2))"/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:value-of select="ancestor::art/kap/rad"/>
    </xsl:otherwise>

  </xsl:choose>
</xsl:template>


<xsl:template name="super">
  <super>
    <xsl:for-each select="ref[@tip='super']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='sub']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </super>
</xsl:template>


<xsl:template name="super2">
  <super>
    <xsl:for-each select=".//ref[@tip='super']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='sub']|key('retro',snc/@mrk)[@tip='sub']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </super>
</xsl:template>


<xsl:template name="sub">
  <sub>
    <xsl:for-each select="ref[@tip='sub']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='super']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </sub>
</xsl:template>


<xsl:template name="sub2">
  <sub>
    <xsl:for-each select=".//ref[@tip='sub']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='super']|key('retro',snc/@mrk)[@tip='super']">
      <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </sub>
</xsl:template>


<xsl:template name="dif">
  <dif>
    <xsl:for-each select="ref[@tip='dif']">
       <r c="{@cel}"/>
    </xsl:for-each>
  </dif>
</xsl:template>


<xsl:template name="dif2">
  <dif>
    <xsl:for-each select=".//ref[@tip='dif']">
       <r c="{@cel}"/>
    </xsl:for-each>
  </dif>
</xsl:template>


<xsl:template name="sin">
  <sin>
    <xsl:for-each select="ref[@tip='sin']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='sin' or @tip='dif']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </sin>
</xsl:template>


<xsl:template name="sin2">
  <sin>
    <xsl:for-each select=".//ref[@tip='sin']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='sin' or @tip='dif']
          |key('retro',snc/@mrk)[@tip='sin' or @tip='dif']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </sin>
</xsl:template>


<xsl:template name="ant">
  <ant>
    <xsl:for-each select="ref[@tip='ant']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='ant']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </ant>
</xsl:template>


<xsl:template name="ant2">
  <ant>
    <xsl:for-each select=".//ref[@tip='ant']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='ant']|key('retro',snc/@mrk)[@tip='ant']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </ant>
</xsl:template>


<xsl:template name="vid">
  <vid>
    <xsl:for-each select="ref[@tip='vid' or not(@tip) or @tip='']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='vid' or not(@tip) or @tip='']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </vid>
</xsl:template>


<xsl:template name="vid2">
  <vid>
    <xsl:for-each select=".//ref[@tip='vid' or not(@tip) or @tip='']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='vid' or not(@tip) or @tip='']
        |key('retro',snc/@mrk)[@tip='vid' or not(@tip) or @tip='']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </vid>
</xsl:template>


<xsl:template name="malprt">
  <malprt>
    <xsl:for-each select="ref[@tip='malprt']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='prt']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </malprt>
</xsl:template>


<xsl:template name="malprt2">
  <malprt>
    <xsl:for-each select=".//ref[@tip='malprt']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='prt']|key('retro',snc/@mrk)[@tip='prt']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </malprt>
</xsl:template>


<xsl:template name="prt">
  <prt>
    <xsl:for-each select="ref[@tip='prt']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='malprt']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </prt>
</xsl:template>


<xsl:template name="prt2">
  <prt>
    <xsl:for-each select=".//ref[@tip='prt']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='malprt']|key('retro',snc/@mrk)[@tip='malprt']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </prt>
</xsl:template>


<xsl:template name="ekz">
  <ekz>
    <xsl:for-each select="ref[@tip='ekz']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='lst']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </ekz>
</xsl:template>


<xsl:template name="ekz2">
  <ekz>
    <xsl:for-each select=".//ref[@tip='ekz']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='lst']|key('retro',snc/@mrk)[@tip='lst']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </ekz>
</xsl:template>


<xsl:template name="lst">
  <lst>
    <xsl:for-each select="ref[@tip='lst']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='ekz']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </lst>
</xsl:template>


<xsl:template name="lst2">
  <lst>
    <xsl:for-each select=".//ref[@tip='lst']">
       <r c="{@cel}"/>
    </xsl:for-each>
    <xsl:for-each select="key('retro',@mrk)[@tip='ekz']|key('retro',snc/@mrk)[@tip='ekz']">
       <r c="{ancestor-or-self::node()[@mrk][1]/@mrk}"/>
    </xsl:for-each>
  </lst>
</xsl:template>


</xsl:stylesheet>










