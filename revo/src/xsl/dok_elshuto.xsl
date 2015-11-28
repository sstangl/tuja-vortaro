<!-- DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
-->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
    xmlns:redirect="http://xml.apache.org/xalan/redirect"
    extension-element-prefixes="redirect">

<!-- kreas la elshuto-paghon el tgz/dosieroj.xml kaj voko/cfg/enhavo.xml -->

<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<xsl:output method="html" encoding="utf-8"/>

<xsl:variable name="enhavo">../cfg/enhavo.xml</xsl:variable>
<xsl:variable name="dosieroj" select="/"/>

<xsl:template match="/">
  <xsl:apply-templates select="document($enhavo)//elshuto"/>
</xsl:template>

<xsl:template match="elshuto">
  <html>
    <head>
      <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
      <title><xsl:value-of select="@titolo"/></title>
    </head>

    <body>

      <h1><xsl:value-of select="@titolo"/></h1>

      <xsl:apply-templates/>

    </body>
  </html>
</xsl:template>


<xsl:template match="sekcio">
  <xsl:variable name="prefikso" select="ero[1]/@ref"/>

  <xsl:if test="$dosieroj/dir/file[starts-with(@name,$prefikso)]">
    <h2><xsl:value-of select="@titolo"/></h2>
    <dl>
      <xsl:apply-templates select="ero"/>
    </dl>
  </xsl:if>
</xsl:template>


<xsl:template match="ero">
  <xsl:variable name="prefikso" select="@ref"/>

  <xsl:if test="$dosieroj/dir/file[starts-with(@name,$prefikso)]">
    <dt><xsl:value-of select="@titolo"/></dt>
    <dd>
      <xsl:apply-templates select="$dosieroj/dir/file[starts-with(@name,$prefikso)]"/>
      <xsl:apply-templates select="alineo|bildo"/>
    </dd>
  </xsl:if>
</xsl:template>


<xsl:template match="file">
  <a href="{@name}"><xsl:value-of select="@name"/></a> 
    (<xsl:value-of select="@size"/>)<br/>
</xsl:template>


<xsl:template match="elshuto/alineo">
  <xsl:if test="position()=last()">
    <hr/>
  </xsl:if>
  <p>
    <xsl:apply-templates/>
  </p>
</xsl:template>


<xsl:template match="ero/alineo">
  <p>
    <xsl:if test="@style">
      <xsl:attribute name="style">
        <xsl:value-of select="@style"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </p>
</xsl:template>


<xsl:template match="bildo">
  <img src="{@loko}" align="center" alt="bildo"/>
</xsl:template>


<xsl:template match="url">
  <a href="{@ref}"><xsl:apply-templates/></a>
</xsl:template>



</xsl:stylesheet>
<!-- /xsl:transform -->



