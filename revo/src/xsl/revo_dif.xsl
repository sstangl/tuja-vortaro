<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- (c) 1999-2003 che Wolfram Diestel

reguloj pri prisklribaj elementoj (dif, ekz, gra ktp.) 
kaj stiloj (em,ctl,sup...)

-->

<!-- fak-informojn memoru en variablo por pli facila aliro -->
<xsl:variable name="fakoj" select="document($fakoj_cfg)/fakoj"/>

<!-- priskribaj elementoj -->

<xsl:template match="gra">
  (<xsl:apply-templates/>)<br />
</xsl:template>

<xsl:template match="dif">
  <span class="dif"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="ekz">
  <i class="ekz"><xsl:apply-templates/></i>
</xsl:template>

<xsl:template match="ekz/tld|ind/tld">
  <span class="ekztld">
  <xsl:choose>
    <xsl:when test="@lit">
      <xsl:value-of select="concat(@lit,substring(ancestor::art/kap/rad,2))"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="ancestor::art/kap/rad"/>
    </xsl:otherwise>
  </xsl:choose>
  </span>
</xsl:template>

<xsl:template match="rim/ekz">
  <cite class="rimekz"><xsl:apply-templates/></cite>
</xsl:template>

<xsl:template match="rim" name="rim">
  <xsl:if test="@mrk">
    <a name="{@mrk}"/>
  </xsl:if>
  <span class="rim">
    <b>
    <xsl:text>Rim.</xsl:text>
    <xsl:if test="@num"> 
      <xsl:text> </xsl:text>
      <xsl:value-of select="@num"/>
    </xsl:if>
    <xsl:text>:</xsl:text>
    </b>
    <xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="rim/aut">
  <xsl:text>[</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="
  art/rim|
  subart/rim|
  drv/rim|
  subdrv/rim|
  snc/rim|
  subsnc/rim">

  <br/>
  <xsl:call-template name="rim"/>
</xsl:template>


<xsl:template match="ofc">
  <sup class="ofc"><xsl:value-of select="."/></sup>
</xsl:template>


<xsl:template match="klr">
  <span class="klr"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="klr[@tip='ind']"/>


<xsl:template match="bld">
  <xsl:if test="$aspekto='ilustrite'">
    <br/>
    <center>
      <xsl:choose>
         <xsl:when test="@tip='svg'">
           <embed class="bld" src="{@lok}" type="image/svg+xml"
                  pluginspace="http://www.adobe.com/svg/viewer/install/">
             <xsl:if test="@alt">
               <xsl:attribute name="height"> 
                 <xsl:value-of select="@alt"/>
               </xsl:attribute>
             </xsl:if>
             <xsl:if test="@lrg">
               <xsl:attribute name="width">
                 <xsl:value-of select="@lrg"/>
               </xsl:attribute> 
             </xsl:if> 
           </embed>
         </xsl:when>
         <xsl:otherwise>
           <img class="bld" src="{@lok}">
             <xsl:if test="@alt">
               <xsl:attribute name="height">
                 <xsl:value-of select="@alt"/>
               </xsl:attribute>
             </xsl:if>
             <xsl:if test="@lrg">
               <xsl:attribute name="width"> 
                 <xsl:value-of select="@lrg"/>
               </xsl:attribute>
             </xsl:if> 
           </img>
         </xsl:otherwise>
      </xsl:choose>
      <br/>
      <i>
        <xsl:apply-templates select="text()|tld|ind|klr|fnt"/>
      </i>
      <br/>
    </center>
  </xsl:if>
</xsl:template>


<xsl:template match="uzo[@tip='fak']">
  <xsl:variable name="fak" select="."/>

  <xsl:choose>

    <xsl:when test="$aspekto='ilustrite'">
       <!-- eltrovu la fakon el fakoj.xml, se la fako ne ekzistas,
            ellasu ghin -->
       <xsl:for-each select="$fakoj/fako[(@kodo=$fak)]">
         <img src="{@vinjeto}" alt="{@kodo}" align="absmiddle" 
           title="{.}" />
       </xsl:for-each>
    </xsl:when>

    <xsl:otherwise>
      <xsl:value-of select="."/>
      <xsl:text> </xsl:text>
    </xsl:otherwise>

  </xsl:choose>

  <xsl:if test="drv/uzo">
    <br />
  </xsl:if>
</xsl:template>


<xsl:template match="uzo[@tip='stl']">
  <xsl:choose>
    <xsl:when test=".='KOMUNE'">
      <xsl:text>(komune) </xsl:text>
    </xsl:when>
    <xsl:when test=".='FIG'">
      <xsl:text>(figure) </xsl:text>
    </xsl:when>
    <xsl:when test=".='ARK'">
      <xsl:text>(arkaismo) </xsl:text>
    </xsl:when>
    <xsl:when test=".='EVI'">
      <xsl:text>(evitinde) </xsl:text>
    </xsl:when>
    <xsl:when test=".='FRAZ'">
      <xsl:text>(fraza&#x0135;o) </xsl:text>
    </xsl:when>
    <xsl:when test=".='VULG'">
      <xsl:text>(vulgare) </xsl:text>
    </xsl:when>
    <xsl:when test=".='RAR'">
      <xsl:text>(malofte) </xsl:text>
    </xsl:when>
    <xsl:when test=".='POE'">
      <xsl:text>(poezie) </xsl:text>
    </xsl:when>
    <xsl:when test=".='NEO'">
      <xsl:text>(neologismo) </xsl:text>
    </xsl:when>    
  </xsl:choose>
  <xsl:if test="drv/uzo">
    <br />
  </xsl:if>
</xsl:template>


<xsl:template match="uzo">
  <xsl:apply-templates/>
  <xsl:if test="drv/uzo">
    <br />
  </xsl:if>
</xsl:template>


<xsl:template match="mlg">
  (<xsl:apply-templates/>)
</xsl:template>


<xsl:template match="url">
  <br />
  <xsl:if test="$aspekto='ilustrite'">
    <img src="{$smbdir}/url.gif" alt="URL:" />
    <a class="url" href="{@ref}" target="_new">
      <xsl:apply-templates/>
    </a>
  </xsl:if>
</xsl:template>

<!-- stiloj -->

<xsl:template match="sub">
  <sub>
  <xsl:apply-templates/>
  </sub>
</xsl:template>


<xsl:template match="sup">
  <sup class="sup"><xsl:value-of select="."/></sup>
</xsl:template>


<xsl:template match="em">
  <strong>
  <xsl:apply-templates/>
  </strong>
</xsl:template>


<xsl:template match="ctl">
  <xsl:text>&#x201e;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#x201c;</xsl:text>
</xsl:template>


<xsl:template match="frm">
  <span class="frm"><xsl:apply-templates/></span>
</xsl:template>


<xsl:template match="k">
  <i><xsl:apply-templates/></i>
</xsl:template>


<xsl:template match="g">
  <b><xsl:apply-templates/></b>
</xsl:template>


</xsl:stylesheet>












