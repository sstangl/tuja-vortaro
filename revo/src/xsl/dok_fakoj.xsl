<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!-- (c) 2002 che Wolfram Diestel

  transformi la fakoliston al HTML

-->


<xsl:output method="html" version="4.0" encoding="utf-8"/>

<xsl:template match="fakoj">
  <html>
    <head>
      <title>mallongigoj de fakoj</title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
    <h1>mallongigoj de fakoj</h1>

    <table align="center">
    <tr><th>kodo</th><th></th><th>fako</th></tr>
    <xsl:for-each select="fako">
      <tr>
        <td><code><xsl:value-of select="@kodo"/></code></td>
        <td>
          <xsl:if test="@vinjeto">
            <img src="{@vinjeto}" alt="" border="0" align="middle"/>
          </xsl:if>
        </td>
        <td>
          <xsl:value-of select="."/>
        </td>
      </tr>
    </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
    





