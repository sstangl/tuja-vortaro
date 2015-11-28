<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">


<!-- (c) 2002 che Wolfram Diestel

  transformi la lingvolisto al HTML

-->


<xsl:output method="html" version="4.0" encoding="utf-8"/>

<xsl:template match="lingvoj">
  <html>
    <head>
      <title>mallongigoj de lingvoj</title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
    <h1>mallongigoj de lingvoj</h1>
    <p>
    Por aldoni tradukojn en nova lingvo, bonvolu sendi al la
    administranto de la vortaro informojn pri alfabeto kaj ordigado.
    </p>

    <table align="center">
    <tr><th>kodo</th><th>lingvo</th></tr>
    <xsl:for-each select="lingvo">
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
    





