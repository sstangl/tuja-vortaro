<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!-- (c) 2002 che Wolfram Diestel

  transformi la mallongigoliston al HTML

-->


<xsl:output method="html" version="4.0" encoding="utf-8"/>

<xsl:variable name="enhavo">../cfg/enhavo.xml</xsl:variable>


<xsl:template match="mallongigoj">
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title><xsl:value-of select="concat(../@nometo,'-indekso: ',@titolo)"/></title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">
        <xsl:call-template name="menuo-ktp"/>
        <tr>
          <td colspan="{count(document($enhavo)//pagho[not(@kashita='jes')])}" class="enhavo">

    <h1>mallongigoj</h1>

    <dl compact="compact">
    <xsl:for-each select="mallongigo">
      <a name="{@mll}"/>
      <dt><xsl:value-of select="@mll"/></dt>
      <dd><xsl:value-of select="."/></dd>
    </xsl:for-each>
    </dl>

          </td>
        </tr>
      </table>
    </body>
  </html>

</xsl:template>


<xsl:template name="menuo-ktp">
  <xsl:for-each select="document($enhavo)//pagho[.//BLD-OJ][1]"> 
    <xsl:call-template name="menuo"/>
  </xsl:for-each>
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

</xsl:stylesheet>
    





