<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!-- (c) 2002 che Wolfram Diestel

  transformi la stiloliston al HTML

-->


<xsl:output method="html" version="4.0" encoding="utf-8"/>

<xsl:template match="stiloj">
  <html>
    <head>
      <title>mallongigoj de stiloj</title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
    <h1>mallongigoj de stiloj</h1>

    <table align="center">
    <tr><th>kodo</th><th>stilo</th></tr>
    <xsl:for-each select="stilo">
      <tr>
        <td><code><xsl:value-of select="@kodo"/></code></td>
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
    





