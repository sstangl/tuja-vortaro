<!DOCTYPE xsl:transform>

<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
>


<!--xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon" 
-->


<!-- (c) 2006 che Wolfram Diestel
     licenco GPL 2.0
-->


<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:variable name="file" select="document-uri(/)"/>
<xsl:variable name="filename" select="substring-before(tokenize($file,'/')[last()],'.xml')"/>
<xsl:variable name="base" select="string-join(tokenize($file,'/')[position() &lt; last()],'/')"/>

<xsl:variable name="lingvoj">../cfg/lingvoj.xml</xsl:variable>
<xsl:variable name="fakoj">../cfg/fakoj.xml</xsl:variable>
<xsl:variable name="stiloj">../cfg/stiloj.xml</xsl:variable>


<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="art">
  <art dos="{$filename}">
  <xsl:variable name="mrk" select="substring-after(substring-before(@mrk,'.xml'),'Id: ')"/>

  <xsl:choose>
    <xsl:when test="$mrk='' or not($mrk)">
      <ero kie="art" mrk="{$mrk}" tip="art-sen-mrk"/>
    </xsl:when>
    <xsl:when test="$mrk != $filename">
      <ero  kie="art" mrk="{$mrk}" tip="mrk-ne-dos"/>
    </xsl:when>    
    <xsl:otherwise>
      <xsl:analyze-string select="$mrk" regex="[^a-z0-9_]">
        <xsl:matching-substring>
          <ero  kie="art" mrk="{$mrk}" tip="art-mrk-sgn"/>
        </xsl:matching-substring>
      </xsl:analyze-string>
    </xsl:otherwise>
  </xsl:choose>


  <xsl:apply-templates/>
  </art>
</xsl:template>


<xsl:template match="drv|snc[@mrk]|subsnc[@mrk]|subart[@mrk]">

  <xsl:variable name="mrk" select="@mrk"/>
  <xsl:variable name="kie" select="node-name(.)"/>

  <xsl:variable name="mrk-fin" select="substring-after(@mrk,'.')"/>

  <xsl:variable name="mrk1">
    <xsl:choose>
      <xsl:when test="contains($mrk,'.')">
         <xsl:value-of select="substring-before($mrk,'.')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$mrk"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="mrk2">
    <xsl:choose>
      <xsl:when test="contains($mrk-fin,'.')">
         <xsl:value-of select="substring-before($mrk-fin,'.')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$mrk-fin"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="not(contains($mrk,'.'))">
      <ero kie="{$kie}" mrk="{$mrk}" tip="mrk-prt"/>
    </xsl:when>
    <xsl:when test="not(contains($mrk2,'0'))">
      <ero kie="{$kie}" mrk="{$mrk}" tip="mrk-nul"/>
    </xsl:when>
    <xsl:when test="$mrk1 != $filename">
      <ero kie="{$kie}" mrk="{$mrk}" tip="mrk-ne-dos"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="uzo">
  <xsl:variable name="mrk" select="ancestor::node()[@mrk][1]/@mrk"/>
  <xsl:variable name="kie" select="node-name(ancestor::node()[@mrk][1])"/>

  <xsl:choose>
    <xsl:when test="@tip='fak'">
      <xsl:if test="not(document($fakoj)//fako[@kodo=current()])">
        <ero kie="{$kie}" mrk="{$mrk}" tip="uzo-fak" arg="{.}"/>
      </xsl:if>
    </xsl:when>
    <xsl:when test="@tip='stl'">
      <xsl:if test="not(document($stiloj)//stilo[@kodo=current()])">
        <ero kie="{$kie}" mrk="{$mrk}" tip="uzo-stl" arg="{.}"/>
      </xsl:if>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template match="trdgrp[@lng]|trd[@lng]">
  <xsl:if test="not(document($lingvoj)//lingvo[@kodo=current()/@lng])">
    <ero kie="{node-name(ancestor::node()[@mrk][1])}" 
         mrk="{ancestor::node()[@mrk][1]/@mrk}" tip="trd-lng" arg="{@lng}"/>
  </xsl:if>
</xsl:template>


<xsl:template match="ref">
  <xsl:variable name="mrk" select="ancestor::node()[@mrk][1]/@mrk"/>
  <xsl:variable name="kie" select="node-name(ancestor::node()[@mrk][1])"/>

  <xsl:variable name="dosiero">
    <xsl:choose>
      <xsl:when test="contains(@cel,'.')">
        <xsl:value-of select="concat($base,'/',substring-before(@cel,'.'),'.xml')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($base,'/',@cel,'.xml')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="cel-fin" select="substring-after(@cel,'.')"/>
  <xsl:variable name="cel2">
    <xsl:choose>
      <xsl:when test="contains($cel-fin,'.')">
         <xsl:value-of select="substring-before($cel-fin,'.')"/>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$cel-fin"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="not(@cel) or @cel=''">
      <ero kie="{$kie}" mrk="{$mrk}" tip="ref-sen-cel" arg="{.}"/>
    </xsl:when>
    <xsl:when test="not(doc-available($dosiero))">
      <ero kie="{$kie}" mrk="{$mrk}" tip="ref-cel-dos" arg="{@cel}"/>
    </xsl:when>
    <xsl:when test="$cel2 != '' and not(contains($cel2,'0'))">
      <ero kie="{$kie}" mrk="{$mrk}" tip="ref-cel-nul" arg="{@cel}"/>
    </xsl:when>
    <xsl:when test="contains(@cel,'.') and not(document($dosiero)//node()[@mrk=current()/@cel])">
      <ero kie="{$kie}" mrk="{$mrk}" tip="ref-cel-mrk" arg="{@cel}"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template match="*">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="text()"/>


</xsl:transform>










