<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:f="http://respiro.steloj.de"
  version="2.0"
  extension-element-prefixes="saxon" 
>

<!-- xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0" -->


<!-- (c) 2002 che Wolfram Diestel

  transformi ordigo.xml al informoj pri alfabetoj kaj ordigado

-->


<xsl:output method="html" version="4.0" encoding="utf-8"/>

<xsl:variable name="literoj" select="'../cfg/literoj.xml'"/>
<xsl:variable name="lingvoj" select="'../cfg/lingvoj.xml'"/>

<xsl:template match="ordigo">
  <html>
    <head>
      <title>literoj kaj ordigado</title>
      <link title="indekso-stilo" type="text/css" 
            rel="stylesheet" href="../stl/artikolo.css"/>
      <style type="text/css">
         table { background-color: #E0E0A0; margin-left: 15% }
         td { background-color: lightblue }
      </style>
    </head>
    <body>
    <h1>literoj kaj ordigado</h1>
    <p>lingvoj:
    <xsl:for-each select="lingvo">
      <a href="#{@lng}"><xsl:value-of select="@lng"/></a><xsl:text> </xsl:text>
    </xsl:for-each>
    </p>

    <p>
    Jen informoj pri la literoj, sub kiu litero(-grupo) ili aperas
    en la indekso (en krampoj estas askia nomo, kiu uzi&#x011d;as ekzemple
    en dosieronomoj de la indeksoj). Krome la nomo de la litero, kiel &#x011d;i
    aperu en la Revo-artikoloj. Ekz. la franca &#x0153; aperu en artikoloj kiel
    &amp;oelig;. En lasta kolumno estas la unikodo de la litero. 
    </p>

    <xsl:apply-templates select="lingvo"/>
  </body>
  </html>
</xsl:template>

<xsl:template name="lingvonomo">
  <xsl:param name="lng"/>
  <xsl:value-of select="document($lingvoj)//lingvo[@kodo=$lng]"/>
</xsl:template>

<xsl:template match="lingvo[@kiel]">
  <a name="{@lng}"/>
  <h2><xsl:text>pri la lingvo </xsl:text>
    <xsl:call-template name="lingvonomo">
      <xsl:with-param name="lng" select="@lng"/>
    </xsl:call-template>
    <xsl:text> vidu &#x0109;e la lingvo </xsl:text>
    <a href="#{@kiel}">
      <xsl:call-template name="lingvonomo">
        <xsl:with-param name="lng" select="@kiel"/>
      </xsl:call-template>
    </a>
  </h2>
</xsl:template>


<xsl:template match="lingvo">
  <a name="{@lng}"/>
  <h2><xsl:text>litergrupoj de la lingvo </xsl:text>
    <xsl:call-template name="lingvonomo">
      <xsl:with-param name="lng" select="@lng"/>
    </xsl:call-template>
  </h2>

  <table>
    <TR>
      <TH ALIGN="LEFT">Grupo</TH>
      <TH ALIGN="LEFT">Litero</TH>
      <TH ALIGN="LEFT">Priskribo</TH>
      <TH ALIGN="LEFT">XML-nomo</TH>
      <TH ALIGN="LEFT">Unikodo</TH>
    </TR>
    <xsl:apply-templates select="l"/>
  </table>
</xsl:template>


<xsl:template match="l">
  <xsl:variable name="literoj" select="translate(.,',','')"/>
  <xsl:variable name="len">
    <xsl:choose>
      <xsl:when test="@n"><xsl:value-of select="@n"/></xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <tr>
    <td rowspan="{string-length($literoj) idiv $len}">
      <xsl:value-of select="substring($literoj,1,$len)"/>
      <xsl:if test="substring($literoj,1,$len) != @name">
        (<xsl:value-of select="@name"/>)
      </xsl:if>
    </td>
    <xsl:for-each select="substring($literoj,1,$len)">
      <xsl:call-template name="litero"/>
    </xsl:for-each>
  </tr>

  <xsl:for-each select="for $l in 1 to (string-length($literoj) idiv $len -1)
                          return substring($literoj,1+$l*$len,$len)">
     <tr>
       <xsl:call-template name="litero"/>
     </tr>
  </xsl:for-each>

</xsl:template>


<xsl:template name="litero">

  <td><xsl:value-of select="."/></td>
  <xsl:choose>
    <xsl:when test="string-length(.)=1 and string-to-codepoints(.)[1] &gt; 127">
      <xsl:variable name="hex" select="f:int2hex(string-to-codepoints(.))"/>
      <xsl:variable name="xhex" select="concat('#x',lower-case($hex))"/>
      <xsl:variable name="lit" select="document($literoj)//l[lower-case(@kodo) eq $xhex][1]/@nomo"/>

      <td>
        <xsl:call-template name="liter-priskribo">
          <xsl:with-param name="liternomo" select="$lit"/>
        </xsl:call-template>
      </td>
      <td>
        <xsl:if test="$lit != ''">
          <xsl:value-of select="concat('&amp;',$lit,';')"/>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="$hex"/>
      </td>
    </xsl:when>
    <xsl:otherwise>
      <td>
        <xsl:call-template name="liter-priskribo">
          <xsl:with-param name="liternomo" select="."/>
        </xsl:call-template>
      </td>
      <td>&#xa0;</td><td>&#xa0;</td>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:function name="f:int2hex" as="xs:string">
  <xsl:param name="in"/>
  <xsl:value-of select="concat(
       f:hex($in idiv (16*16*16)),
       f:hex(($in mod (16*16*16)) idiv (16*16)),
       f:hex(($in mod (16*16)) idiv 16),
       f:hex($in mod 16))"/>
</xsl:function>


<xsl:function name="f:hex" as="xs:string">
  <xsl:param name="in"/>
  <xsl:value-of select="substring('0123456789ABCDEF',$in+1,1)"/>
  <!--xsl:value-of select="concat($in,',')"/ -->
</xsl:function>


<xsl:template name="liter-priskribo">
  <xsl:param name="liternomo"/>

  <xsl:choose>
    <xsl:when test="not($liternomo)">
       <xsl:text>---</xsl:text>
    </xsl:when>
    <xsl:otherwise>

      <xsl:variable name="prefikso" select="substring-before($liternomo,'_')"/>
      <xsl:variable name="pref_pri" select="document($literoj)//prefiksoj/p[@nomo=$prefikso]/@pri"/>
    
      <xsl:if test="$pref_pri != ''">
	<xsl:value-of select="$pref_pri"/>
	<xsl:text> </xsl:text>
      </xsl:if>

      <xsl:variable name="resto">
	<xsl:choose>
	  <xsl:when test="$pref_pri != ''">
	    <xsl:value-of select="substring-after($liternomo,'_')"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$liternomo"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>


      <xsl:variable name="sufikso" select="document($literoj)//sufiksoj/s
	 [@nomo=substring($resto,number(substring(concat(@n,'1'),1,1))+1)]"/>

      <xsl:variable name="litero">
	 <xsl:choose>
	   <xsl:when test="$sufikso">
	     <xsl:value-of select="substring($resto,1,
                  string-length($resto) - string-length($sufikso/@nomo))"/>
	   </xsl:when>
	   <xsl:otherwise>
	    <xsl:value-of select="$resto"/>
	   </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:if test="string-length($litero)&lt;=2">
        <xsl:choose>
	  <xsl:when test="lower-case($litero) eq $litero">
	    <xsl:value-of select="'minuskla '"/>
  	  </xsl:when>
  	  <xsl:otherwise>
	    <xsl:value-of select="'majuskla '"/>
	  </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:value-of select="concat(translate($litero,'_',' '),' ')"/>

      <xsl:if test="$sufikso">
	<xsl:value-of select="$sufikso/@pri"/>
      </xsl:if>

    </xsl:otherwise>
 </xsl:choose>

</xsl:template>


<!--/xsl:stylesheet -->
</xsl:transform>
    





