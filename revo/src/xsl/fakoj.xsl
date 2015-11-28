<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
                version="1.0"
                extension-element-prefixes="xt">

<!-- (c) 2002 che Wolfram Diestel

  Tiu XSL-dosiero provas krei la fakindeksojn per XSL-rimedoj.
  Tio ne tute sukcesas pro la sekvaj limigoj:
  
  "xt" erare indeksas nur unufoje erojn, en kiuj <uzo> aperas
  plurfoje. Krome aplikata al la tuta indekso mortas pro memormanko.

  "xsltproc" ne povas ordigi lau lingvoj, do nek ghuste ordigas lau
  Eo, sed cetere bone sukcesas. Por la tuta indekso bezonas che mi 3
  min.

  Cetere xsltproc subtenas la elementon <xsl:document>, sed ankau
  subtenas ghin kiel <xt:document> kun la supraj etendo-deklaroj.
-->


<xsl:output method="html" version="4.0" encoding="utf-8"/>

<!-- enlegu la fakoliston -->
<xsl:variable name="fakoj_cfg">../cfg/fakoj.xml</xsl:variable>
<xsl:variable name="fakoj" select="document($fakoj_cfg)/fakoj"/>


<!-- indeksigu chiujn erojn lau fakindikoj -->
<xsl:key name="uzataj_fakoj"
         match="//art|//subart|//drv|//subdrv|//snc|//subsnc"
         use="uzo"/>

<!--xsl:key name="uzataj_fakoj"
         match="//drv"
         use="uzo"/-->

<xsl:template match="vortaro">
  <xsl:variable name="radiko" select="."/>
  <xsl:for-each select="$fakoj/fako">

    <xsl:sort lang="eo"/>
    <xsl:message>
      <xsl:value-of select="@kodo"/><xsl:text> - </xsl:text><xsl:value-of select="."/>
    </xsl:message>

    <xsl:call-template name="fako">
      <xsl:with-param name="fako" select="."/>
      <xsl:with-param name="radiko" select="$radiko"/>

    </xsl:call-template> 
  </xsl:for-each>
</xsl:template>

<xsl:template name="fako">
 <xsl:param name="fako"/>
 <xsl:param name="radiko"/>

  <!-- reshaltu al kunteksto de <vortaro> -->
  <xsl:for-each select="$radiko"> 
    <xsl:if test="key('uzataj_fakoj',$fako/@kodo)">
      <xt:document method="html" version="4.0" encoding="utf-8"
          href="inx/fx_{$fako/@kodo}.html">
        <html>
          <head>
            <title>$fako</title>
          </head>
          <body>
            <xsl:apply-templates
              select="key('uzataj_fakoj',$fako/@kodo)">
              <xsl:sort lang="eo" 
                select="(ancestor-or-self::art|ancestor-or-self::drv)[last()]/kap"/>
            </xsl:apply-templates>
          </body>
        </html>
      </xt:document>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="art|subart|drv|subdrv|snc|subsnc">
  <xsl:variable name="mrk" select="ancestor-or-self::node()[@mrk][1]/@mrk"/>
  <a target="precipa"
     href="../art/{substring-before($mrk,'.')}.html#{$mrk}">
    <xsl:value-of
      select="(ancestor-or-self::art|ancestor-or-self::drv)[last()]/kap"/>
  </a>
  <br/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="trd|ref|refgrp|trdgrp"/>

</xsl:stylesheet>









