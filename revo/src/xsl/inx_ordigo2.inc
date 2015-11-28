<?xml version="1.0" encoding="UTF-8"?>
<!-- tiu chi dosiero estas automate farita el voko/cfg/ordigo2.xml -->
<!DOCTYPE xsl:transform [

<!ENTITY sort-eo " = '|' &lt; a,A &lt; b,B &lt; c,C &lt; ĉ,Ĉ &lt; d,D &lt; e,E &lt; f,F &lt; g,G &lt; ĝ,Ĝ &lt; h,H &lt; ĥ,Ĥ &lt; i,I &lt; j,J &lt; ĵ,Ĵ &lt; k,K &lt; l,L &lt; m,M &lt; n,N &lt; o,O &lt; p,P &lt; r,R &lt; s,S &lt; ŝ,Ŝ &lt; t,T &lt; u,U &lt; ŭ,Ŭ &lt; v,V &lt; z,Z">

<!ENTITY sort-br " = '|' &lt; a,A &lt; b,B &lt; ch,cH,Ch,CH &lt; c'h,c'H,C'h,C'H &lt; d,D &lt; e,E &lt; f,F &lt; g,G &lt; h,H &lt; i,I &lt; j,J &lt; k,K &lt; l,L &lt; m,M &lt; n,N,q,Q &lt; o,O &lt; p,P &lt; r,R &lt; s,S &lt; t,T &lt; u,U,ù,Ù,ü,Ü &lt; v,V &lt; w,W &lt; x,X &lt; y,Y &lt; z,Z">

<!ENTITY sort-ca " = '|' &lt; a,A,à,À &lt; b,B &lt; c,C,ç,Ç &lt; d,D &lt; e,E,é,É,è,È &lt; f,F &lt; g,G &lt; h,H &lt; i,I,í,Í,ï,Ï &lt; j,J &lt; k,K &lt; l,L,l·,L· &lt; m,M &lt; n,N &lt; o,O,ó,Ó,ò,Ò &lt; p,P &lt; q,Q &lt; r,R &lt; s,S &lt; t,T &lt; u,U,ú,Ú,ü,Ü &lt; v,V &lt; w,W &lt; x,X &lt; y,Y &lt; z,Z">

<!ENTITY sort-cy " = '|' &lt; a,A &lt; b,B &lt; c,C &lt; ch,cH,Ch,CH &lt; d,D &lt; e,E &lt; f,F &lt; ff,fF,Ff,FF &lt; g,G &lt; h,H &lt; i,I &lt; j,J &lt; l,L &lt; ll,lL,Ll,LL &lt; m,M &lt; n,N &lt; o,O &lt; p,P &lt; ph,pH,Ph,PH &lt; r,R &lt; rh,rH,Rh,RH &lt; s,S &lt; t,T &lt; th,tH,Th,TH &lt; u,U &lt; w,W,ẃ,Ẃ,ẁ,Ẁ,ŵ,Ŵ,ẅ,Ẅ &lt; y,Y,ỳ,Ỳ,ŷ,Ŷ,Ÿ">

<!ENTITY sort-es " = '|' &lt; a,A,á,Á &lt; b,B &lt; c,C &lt; ch,cH,Ch,CH &lt; d,D &lt; e,E,é,É &lt; f,F &lt; g,G &lt; h,H &lt; i,I,í,Í &lt; j,J &lt; k,K &lt; l,L &lt; ll,lL,Ll,LL &lt; m,M &lt; n,N &lt; ñ,Ñ &lt; o,O,ó,Ó &lt; p,P &lt; q,Q &lt; r,R &lt; s,S &lt; t,T &lt; u,U,ú,Ú,ü,Ü &lt; v,V &lt; w,W &lt; x,X &lt; y,Y &lt; z,Z">

<!ENTITY sort-fa " = '|' = '!' = '.' = ':' = '(' = ')' = '[' = ']' = … = ، = ؛ = ؟ = ـ = ‌ = ‍ = َ = ِ = ُ = ً = ٍ = ٌ = ّ = ْ = ٓ = ٔ = ٕ = ٰ = ٖ &lt; ' ' &lt; ۰,٠ &lt; ۱,١ &lt; ۲,٢ &lt; ۳,٣ &lt; ۴,٤ &lt; ۵,٥ &lt; ۶,٦ &lt; ۷,٧ &lt; ۸,٨ &lt; ۹,٩ &lt; آ &lt; ا,ٱ &lt; ء,أ,إ,ؤ,ئ &lt; ب &lt; پ &lt; ت &lt; ث &lt; ج &lt; چ &lt; ح &lt; خ &lt; د &lt; ذ &lt; ر &lt; ز &lt; ژ &lt; س &lt; ش &lt; ص &lt; ض &lt; ط &lt; ظ &lt; ع &lt; غ &lt; ف &lt; ق &lt; ک,ك &lt; گ &lt; ل &lt; م &lt; ن &lt; و &lt; ه,ة &lt; ی,ى,ي &amp; آ = آ &amp; أ = أ &amp; ؤ = ؤ &amp; إ = إ &amp; ئ = ئ">
]>
<xsl:transform
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/"
  version="2.0"
  extension-element-prefixes="saxon">
<saxon:collation name="eo" lang="eo" rules="&sort-eo;"/>
<saxon:collation name="br" lang="br" rules="&sort-br;"/>
<saxon:collation name="ca" lang="ca" rules="&sort-ca;"/>
<saxon:collation name="cy" lang="cy" rules="&sort-cy;"/>
<saxon:collation name="es" lang="es" rules="&sort-es;"/>
<saxon:collation name="fa" lang="fa" rules="&sort-fa;"/>

<xsl:template name="trd-litero">
  <xsl:param name="trdoj"/>
  <xsl:param name="ordlng"/>
  <xsl:param name="lit-name"/>
  <xsl:param name="lit-min"/>

  <xsl:choose>

  <xsl:when test="$ordlng='br'">
      <litero name="{$lit-name}" min="{$lit-min}">
        <xsl:for-each select="$trdoj">
          <xsl:sort collation="br" lang="br" select="concat(t,'|',t1)"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>        
    </xsl:when>

  <xsl:when test="$ordlng='ca'">
      <litero name="{$lit-name}" min="{$lit-min}">
        <xsl:for-each select="$trdoj">
          <xsl:sort collation="ca" lang="ca" select="concat(t,'|',t1)"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>        
    </xsl:when>

  <xsl:when test="$ordlng='cy'">
      <litero name="{$lit-name}" min="{$lit-min}">
        <xsl:for-each select="$trdoj">
          <xsl:sort collation="cy" lang="cy" select="concat(t,'|',t1)"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>        
    </xsl:when>

  <xsl:when test="$ordlng='es'">
      <litero name="{$lit-name}" min="{$lit-min}">
        <xsl:for-each select="$trdoj">
          <xsl:sort collation="es" lang="es" select="concat(t,'|',t1)"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>        
    </xsl:when>

  <xsl:when test="$ordlng='fa'">
      <litero name="{$lit-name}" min="{$lit-min}">
        <xsl:for-each select="$trdoj">
          <xsl:sort collation="fa" lang="fa" select="concat(t,'|',t1)"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>        
    </xsl:when>

    <xsl:otherwise>
      <litero name="{$lit-name}" min="{$lit-min}">
        <xsl:for-each select="$trdoj">
          <xsl:sort lang="{$ordlng}" select="concat(t,'|',t1)"/>
          <xsl:call-template name="v"/>
        </xsl:for-each>
      </litero>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:transform>
