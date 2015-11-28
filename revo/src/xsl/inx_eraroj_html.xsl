<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<xsl:output method="html" encoding="utf-8" indent="no"/>


<xsl:param name="verbose" select="'false'"/>


<!-- xsl:variable name="fakoj">../cfg/fakoj.xml</xsl:variable -->
<xsl:variable name="enhavo">../cfg/enhavo.xml</xsl:variable>
  <xsl:variable name="inx_paghoj" select="count(document($enhavo)//pagho[not(@kashita='jes')])"/>

<xsl:variable name="root" select="/"/>


<xsl:template match="/">

  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title><xsl:text>eraroraporto</xsl:text></title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">
        <xsl:call-template name="menuo-ktp"/>
        <tr>
          <td colspan="{$inx_paghoj}" class="enhavo">
            <h1><xsl:text>eraroraporto</xsl:text></h1>
            <dl>
            <xsl:apply-templates select="//art[ero]">
              <xsl:sort select="@dos"/>
            </xsl:apply-templates>
            </dl>
          </td>
        </tr>
      </table>
    </body>
  </html>
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


<xsl:template name="menuo-ktp">
  <xsl:for-each select="document($enhavo)//pagho[.//INV][1]"> 
    <xsl:call-template name="menuo"/>
  </xsl:for-each>
</xsl:template>


<xsl:template match="art">
  <dt>
    <a href="{concat('../art/',@dos,'.html')}" target="precipa"><b><xsl:value-of select="@dos"/></b></a>
  </dt>
  <dd>
    <xsl:apply-templates select="ero"/>
  </dd>
</xsl:template>

<xsl:template match="ero">
  <p>
    <span class="dato">
      <xsl:value-of select="concat('en &lt;',@kie,' mrk=&quot;',@mrk,'&quot;&gt;:')"/>
    </span>
    <br/>
    <xsl:choose>

      <xsl:when test="@tip='art-sen-mrk'">
        Mankas atributo "mrk" en artikolo.
      </xsl:when>
      <xsl:when test="@tip='art-mrk-sgn'">
        Dosieronomo enhavu nur signojn el literoj, ciferoj kaj substreko.
      </xsl:when>

      <xsl:when test="@tip='mrk-ne-dos'">
        Unua parto de la atributo "mrk" ne egalas al la dosiernomo.
      </xsl:when>
      <xsl:when test="@tip='mrk-prt'">
        Atributo "mrk" ne havas partojn.
      </xsl:when>
      <xsl:when test="@tip='mrk-nul'">
        Dua parto de la atributo "mrk" ne enhavas la signon "0".
      </xsl:when>

      <xsl:when test="@tip='uzo-fak'">
        Fako "<xsl:value-of select="@arg"/>" ne estas difinita.
      </xsl:when>
      <xsl:when test="@tip='uzo-stl'">
        Stilo "<xsl:value-of select="@arg"/>" ne estas difinita.
      </xsl:when>
      <xsl:when test="@tip='trd-lng'">
        Lingvo "<xsl:value-of select="@arg"/>" ne estas difinita.
      </xsl:when>

      <xsl:when test="@tip='ref-sen-cel'">
        Referenco sen atributo "cel".
      </xsl:when>
      <xsl:when test="@tip='ref-cel-nul'">
        Dua parto de la atributo "cel" de referenco ne enhavas la signon "0":
        "<xsl:value-of select="@arg"/>"
      </xsl:when>
      <xsl:when test="@tip='ref-cel-dos'">
        Referenco celas al dosiero "<xsl:call-template name="dosiero"/>",
        kiu ne ekzistas.
      </xsl:when>
      <xsl:when test="@tip='ref-cel-mrk'">
        Referenco celas al "<xsl:value-of select="@arg"/>", kiu ne ekzistas en
        dosiero "<xsl:call-template name="dosiero"/>".
      </xsl:when>

      <xsl:otherwise>
        Nekonata eraro de la tipo "<xsl:value-of select="@tip"/>".
      </xsl:otherwise>
    </xsl:choose>
  </p>
</xsl:template>

<xsl:template name="dosiero">
    <xsl:choose>
      <xsl:when test="contains(@arg,'.')">
        <xsl:value-of select="concat(substring-before(@arg,'.'),'.xml')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(@arg,'.xml')"/>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>


</xsl:stylesheet>










