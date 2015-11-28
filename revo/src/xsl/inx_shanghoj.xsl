<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
>

<!-- xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect" -->


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<xsl:output method="xhtml" encoding="utf-8"/>

<xsl:variable name="enhavo">../cfg/enhavo.xml</xsl:variable>

<xsl:key name="autoroj" match="//entry" use="substring-before(msg,':')"/>


<xsl:template match="/">
  <xsl:call-template name="shanghoj"/>
  <xsl:call-template name="novaj"/>
</xsl:template>


<xsl:template name="shanghoj">
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title>laste &#x015d;an&#x011d;itaj artikoloj</title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">
        <xsl:call-template name="menuo-ktp"/>
        <tr>
          <td colspan="{count(document($enhavo)//pagho[not(@kashita='jes')])}" 
              class="enhavo">
            <h1>laste &#x015d;an&#x011d;itaj</h1>
            <ul>
              <xsl:for-each select="//entry[count(.
                |key('autoroj',substring-before(msg,':'))[1])=1]">

                <xsl:sort select="substring-before(msg,':')"/>

                <li>
                  <a>
                    <xsl:attribute name="href">
                      <xsl:text>#</xsl:text>
                      <xsl:call-template name="autoro">
                        <xsl:with-param name="spaco" select="'_'"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:call-template name="autoro">
                      <xsl:with-param name="spaco" select="' '"/>
                    </xsl:call-template>
                  </a>
                </li>
              
              </xsl:for-each>
            </ul>

            <xsl:for-each select="//entry[count(.
                |key('autoroj',substring-before(msg,':'))[1])=1]">

                <xsl:sort select="substring-before(msg,':')"/>
                <hr/>
                <a>
                  <xsl:attribute name="name">
                    <xsl:call-template name="autoro">
                      <xsl:with-param name="spaco" select="'_'"/>
                    </xsl:call-template>
                  </xsl:attribute>
                </a>
                <h2>
                  <xsl:call-template name="autoro">
                    <xsl:with-param name="spaco" select="' '"/>
                  </xsl:call-template>
                </h2>
                <dl>
                  <xsl:apply-templates select="key('autoroj',substring-before(msg,':'))">
                    <xsl:sort select="date" order="descending"/>
                  </xsl:apply-templates>
                </dl>
              
            </xsl:for-each>

          </td>
        </tr>
      </table>
    </body>
  </html>
</xsl:template>


<xsl:template name="novaj">
  <xsl:result-document href="novaj.html" method="xhtml" encoding="utf-8">
  <!-- redirect:write select="'novaj.html'" -->
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
      <title>novaj artikoloj</title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/indeksoj.css"/>
    </head>
    <body>
      <table cellspacing="0">
        <xsl:call-template name="menuo-ktp"/>
        <tr>
          <td colspan="{count(document($enhavo)//pagho[not(@kashita='jes')])}" 
              class="enhavo">
            <h1>novaj artikoloj</h1>
            <dl>
            <xsl:for-each
               select="//entry[substring-after(msg,':')=' nova artikolo']/file">
 
              <!-- xsl:sort lang="eo" select="name"/ -->
              <xsl:sort select="../date" order="descending"/>
              <xsl:sort lang="eo" select="name"/>
         
              <xsl:call-template name="nova_artikolo"/>

            </xsl:for-each>
            </dl>
          </td>
        </tr>
      </table>
    </body>
  </html>
  <!-- /redirect:write -->
  </xsl:result-document>
</xsl:template>


<xsl:template name="autoro">
  <xsl:param name="spaco"/>
  <xsl:choose>
    <xsl:when test="substring-before(ancestor-or-self::entry/msg,':')">
      <xsl:value-of select="translate(substring-before(ancestor-or-self::entry/msg,':'),' ',$spaco)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>revo</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
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


<xsl:template match="entry">
  <xsl:apply-templates select="file"/>
</xsl:template>

<xsl:template match="entry/file">
  <dt>
    <a target="precipa">
     <xsl:attribute name="href">
       <xsl:text>../art/</xsl:text>
       <xsl:value-of select="substring-before(name,'.xml')"/>
       <xsl:text>.html</xsl:text>
     </xsl:attribute>
     <b><xsl:value-of select="substring-before(name,'.xml')"/></b>
    </a> 
    <xsl:text> </xsl:text>
    <span class="dato"><xsl:value-of select="../date"/></span>
  </dt>
  <dd>
    <xsl:choose>
      <xsl:when test="substring-after(../msg,':')">
        <xsl:value-of select="substring-after(../msg,':')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="../msg"/>
      </xsl:otherwise>
    </xsl:choose>
  </dd>
</xsl:template>


<xsl:template name="nova_artikolo">
  <dt>
    <a target="precipa">
     <xsl:attribute name="href">
       <xsl:text>../art/</xsl:text>
       <xsl:value-of select="substring-before(name,'.xml')"/>
       <xsl:text>.html</xsl:text>
     </xsl:attribute>
     <b><xsl:value-of select="substring-before(name,'.xml')"/></b>
    </a> 
    <xsl:text> </xsl:text>
    <span class="dato"><xsl:value-of select="../date"/></span>
  </dt>
  <dd>
    <xsl:text>de </xsl:text>
    <xsl:call-template name="autoro">
      <xsl:with-param name="spaco" select="' '"/>
    </xsl:call-template>
  </dd>
</xsl:template>


<!-- /xsl:stylesheet -->
</xsl:transform>



