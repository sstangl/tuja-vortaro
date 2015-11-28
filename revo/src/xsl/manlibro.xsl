<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
		version="1.0"
                extension-element-prefixes="xt">

<xsl:output method="html" version="3.2" cdata-section-elements="code"/>
<xsl:strip-space elements=""/>

<!--

kreita de Wolfram Diestel

-->

<xsl:variable name="cssdir">../stl</xsl:variable>

<xsl:template match="/manlibro">
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <link title="artikolo-stilo" type="text/css" rel="stylesheet"
    href="{$cssdir}/artikolo.css" />
  <title><xsl:value-of select="h1"/></title>
  <style type="text/css">
  <xsl:comment>
        .code { background-color : #eeeebb; padding: 0.1cm }
        .element { color : blue }
        .attribute { color: #007700 }
        .attribute-value { color: #004400 }
        .content { color: black}
        .comment { color: #777777 }
  </xsl:comment>
  </style>

  </head>
  <body>
  
   <xsl:apply-templates select="h1"/>
   <xsl:call-template name="enhavo"/> 
   <xsl:apply-templates select="*[not(self::h1)]"/>
  
  </body>
  </html>
</xsl:template>

<!-- art, subart -->

<xsl:template name="enhavo">
  <ul>
  <xsl:for-each select="//h2[@id]">
    <li><a href="#{@id}"><xsl:value-of select="."/></a></li>
  </xsl:for-each>
  </ul>
</xsl:template>

<xsl:template match="h1|h3|p|ol|ul|li|dl|dt|dd|a|
	      table|tr|th|td|blockquote|br|hr">
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h2">
  <xsl:if test="@id">
    <a name="{@id}"/>
  </xsl:if>
  <xsl:copy-of select="."/>
</xsl:template>    

<xsl:template match="code">
  <div class="code">
    <pre>
      <xsl:apply-templates/>
    </pre>
  </div> 
</xsl:template>

<xsl:template match="code//*|code//@*">
  <span class="element">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="local-name()"/>
  </span>
  <xsl:for-each select="attribute::*">
    <xsl:text> </xsl:text>
    <span class="attribute">
      <xsl:value-of select="local-name()"/>
      <xsl:text>="</xsl:text>
    </span>
    <span class="attribute-value">
      <xsl:value-of select="."/>
    </span>
    <span class="attribute">
      <xsl:text>"</xsl:text>
    </span>
  </xsl:for-each>
  <xsl:choose>
    <xsl:when test="text()|node()">
      <span class="element">
        <xsl:text>&gt;</xsl:text>
      </span>
      <xsl:apply-templates/>
      <span class="element">
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>&gt;</xsl:text>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <span class="element">
        <xsl:text>/&gt;</xsl:text>
      </span>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="code//comment()">
  <span class="comment">
    <xsl:text>&lt;!--</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>--&gt;</xsl:text>
  </span>
</xsl:template>

<xsl:template match="code//text()">
  <span class="content">
    <xsl:value-of select="."/>
  </span>
</xsl:template>

</xsl:stylesheet>











