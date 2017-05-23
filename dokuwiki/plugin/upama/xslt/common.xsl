<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="x">
<xsl:output method="html" indent="no" omit-xml-declaration="yes"/>

<xsl:template match="x:teiHeader">
    <ul id="__upama_listWit">
    <xsl:element name="li">
        <xsl:attribute name="data-msid"><xsl:value-of select="x:fileDesc/x:sourceDesc/x:msDesc/x:msIdentifier/x:idno[@type='siglum']"/></xsl:attribute>
        <xsl:element name="span">
            <xsl:attribute name="class">thisWitness</xsl:attribute>
            <xsl:apply-templates select="x:fileDesc/x:sourceDesc/x:msDesc/x:msIdentifier/x:idno[@type='siglum']/node()"/>
        </xsl:element>
    </xsl:element>
    <xsl:for-each select="x:fileDesc/x:sourceDesc/x:listWit/x:witness">
        <xsl:element name="li">
            <xsl:attribute name="data-msid"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:attribute name="data-url"><xsl:value-of select="@ref"/></xsl:attribute>
            <xsl:apply-templates select="x:idno/node()"/>
        </xsl:element>
    </xsl:for-each>
    </ul>
</xsl:template>

<xsl:template match="x:TEI">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="x:text">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="x:body">
    <xsl:apply-templates />
</xsl:template>

<xsl:template name="lang">
    <xsl:choose>
    <xsl:when test="@xml:lang">
        <xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
        <xsl:attribute name="lang">sa</xsl:attribute>
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="x:div1">
    <div class="section">
        <xsl:apply-templates />
    </div>
</xsl:template>

<xsl:template match="x:div">
    <div class="section">
        <xsl:apply-templates />
    </div>
</xsl:template>

<xsl:template match="x:text//x:head">
    <xsl:element name="h2">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:text//x:head[@type='sub']">
    <xsl:element name="h3">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:milestone">
    <xsl:variable name="no" select="@n"/>
    <xsl:variable name="facs" select="/x:TEI/x:facsimile/x:graphic[@n=$no]/@url"/>
    <xsl:choose>
    <xsl:when test="string($facs)">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$facs"/>
            </xsl:attribute>
                <xsl:attribute name="class">milestone<xsl:call-template name="ignore" /></xsl:attribute>
                <xsl:attribute name="lang">en</xsl:attribute>
            <xsl:text>(From </xsl:text>
            <xsl:choose>
            <xsl:when test="@unit">
                <xsl:value-of select="@unit"/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'pothi']">
                <xsl:text>folio </xsl:text>
            </xsl:when>
<xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'book']">
                <xsl:text>page </xsl:text>
            </xsl:when>
            </xsl:choose>
            <xsl:value-of select="$no"/>
            <xsl:text>)</xsl:text>
        </xsl:element>
    </xsl:when>
    <xsl:otherwise>
        <xsl:element name="span">
            <xsl:attribute name="class">milestone<xsl:call-template name="ignore" /></xsl:attribute>
                <xsl:attribute name="lang">en</xsl:attribute>
            <xsl:text>(From </xsl:text>
            <xsl:choose>
            <xsl:when test="@unit">
                <xsl:value-of select="@unit"/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'pothi']">
                <xsl:text>folio </xsl:text>
            </xsl:when>
<xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'book']">
                <xsl:text>page </xsl:text>
            </xsl:when>
            </xsl:choose>
<xsl:value-of select="$no"/>
            <xsl:text>)</xsl:text>
        </xsl:element>
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="x:p">
    <xsl:element name="p">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:sub">
    <sub>
        <xsl:apply-templates/>
    </sub>
</xsl:template>

<xsl:template match="x:sup">
    <sup>
        <xsl:apply-templates/>
    </sup>
</xsl:template>

<xsl:template match="x:editor">
    <span class="editor" lang="en">[<xsl:apply-templates />]</span>
</xsl:template>

<xsl:template name="ignore">
    <xsl:if test="@ignored='TRUE'"> ignored</xsl:if>
    <xsl:if test="@upama-show='TRUE'"> upama-show</xsl:if>
</xsl:template>

<xsl:template match="x:unclear">
    <xsl:element name="span">
        <xsl:attribute name="class">unclear<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:attribute name="data-balloon">
            <xsl:text>unclear</xsl:text>
            <xsl:if test="@reason"> (<xsl:value-of select="@reason"/>)</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:subst">
    <xsl:element name="span">
    <xsl:attribute name="class">subst<xsl:call-template name="ignore"/></xsl:attribute>
    <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:choice">
    <xsl:element name="span">
    <xsl:attribute name="class">choice<xsl:call-template name="ignore"/></xsl:attribute>
    <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:del">
    <xsl:element name="del">
        <xsl:attribute name="data-balloon">
            <xsl:text>deleted</xsl:text>
            <xsl:if test="@rend"> (<xsl:value-of select="@rend"/>)</xsl:if>
        </xsl:attribute>
        <xsl:if test="@ignored='TRUE' or @upama-show='TRUE'">
            <xsl:attribute name="class"><xsl:call-template name="ignore"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:sic">
    <xsl:element name="span">
        <xsl:attribute name="data-balloon">sic</xsl:attribute>
        <xsl:attribute name="class">sic<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:surplus">
    <xsl:element name="span">
        <xsl:attribute name="data-balloon">
            <xsl:text>surplus</xsl:text>
            <xsl:if test="@reason"> (<xsl:value-of select="@reason"/>)</xsl:if>
        </xsl:attribute>
        <xsl:attribute name="class">surplus<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>


<xsl:template match="x:orig">
    <xsl:element name="del">
        <xsl:attribute name="data-balloon">original text</xsl:attribute>
        <xsl:attribute name="class">orig<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:add">
    <xsl:element name="ins">
        <xsl:attribute name="data-balloon">
            <xsl:text>inserted</xsl:text>
            <xsl:if test="@place"> (<xsl:value-of select="@place"/>)</xsl:if>
        </xsl:attribute>
        <xsl:attribute name="class">add<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:corr">
    <xsl:element name="ins">
        <xsl:attribute name="data-balloon">corrected by the transcriber</xsl:attribute>
        <xsl:attribute name="class">corr<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:lb">
    <xsl:element name="span">
        <xsl:choose>
            <xsl:when test="@n">
                <xsl:attribute name="data-balloon">line <xsl:value-of select="@n"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="data-balloon">line break</xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">lb<xsl:call-template name="ignore" /></xsl:attribute>
    <xsl:text disable-output-escaping="yes">⸤</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="x:pb">
    <xsl:variable name="pageno" select="@n"/>
    <xsl:variable name="facs" select="/x:TEI/x:facsimile/x:graphic[@n=$pageno]/@url"/>
    <xsl:choose>
    <xsl:when test="string($facs)">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$facs"/>
            </xsl:attribute>
            
            <xsl:choose>
                <xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'book']">
        <xsl:attribute name="data-balloon">page <xsl:value-of select="@n"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
        <xsl:attribute name="data-balloon">folio <xsl:value-of select="@n"/></xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>

                <xsl:attribute name="class">pb<xsl:call-template name="ignore" /></xsl:attribute>
                <xsl:attribute name="lang">en</xsl:attribute>
            <xsl:text>L</xsl:text>
        </xsl:element>
    </xsl:when>
    <xsl:otherwise>
        <xsl:element name="span">
            
            <xsl:choose>
                <xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'book']">
        <xsl:attribute name="data-balloon">page <xsl:value-of select="@n"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
        <xsl:attribute name="data-balloon">folio <xsl:value-of select="@n"/></xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:attribute name="class">pb<xsl:call-template name="ignore" /></xsl:attribute>
            <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:text>L</xsl:text>
        </xsl:element>
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="x:g">
        <xsl:element name="span">
            <xsl:attribute name="class">glyph<xsl:call-template name="ignore"/></xsl:attribute>
            <xsl:variable name="ref" select="translate(@ref,'#','')"/>
            <xsl:variable name="gdesc" select="/x:TEI/x:teiHeader/x:encodingDesc/x:charDecl/x:glyph[@xml:id=$ref]/x:desc"/>
            <xsl:variable name="devanagari" select="/x:TEI/x:teiHeader/x:encodingDesc/x:charDecl/x:glyph[@xml:id=$ref]/x:mapping[@type='devanagari']"/>
        <xsl:choose>
        <xsl:when test="$gdesc">
        <xsl:attribute name="data-balloon">glyph (<xsl:value-of select="$gdesc"/>)</xsl:attribute>
        </xsl:when>
        <xsl:when test="@rend">
            <xsl:attribute name="data-balloon">glyph (<xsl:value-of select="@rend"/>)</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
        <xsl:attribute name="data-balloon">special glyph</xsl:attribute>
        </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$devanagari">
            <xsl:variable name="font" select="$devanagari/@rend"/>
            <xsl:attribute name="data-devanagari-glyph"><xsl:value-of select="$devanagari"/></xsl:attribute>
            <xsl:if test="$font">
                <xsl:attribute name="data-devanagari-font"><xsl:value-of select="$font"/></xsl:attribute>
            </xsl:if>
        </xsl:if>
            <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:ptr">
    <xsl:variable name="targetname" select="translate(@target,'#','')"/>
    <xsl:variable name="target" select="//*[@id=$targetname]"/>
    <xsl:element name="span">
        <xsl:attribute name="class">pointer<xsl:call-template name="ignore"/></xsl:attribute>
        <xsl:if test="@id">
            <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$target/@reason">
             <xsl:attribute name="data-balloon"><xsl:value-of select="$target/@reason"/></xsl:attribute>
        </xsl:if>
        <xsl:variable name="targettext" select="$target/child::node()[not(self::x:locus)]"/>
        <xsl:apply-templates select="$targettext"/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:supplied">
    <xsl:element name="span">
        <xsl:attribute name="class">supplied<xsl:call-template name="ignore"/></xsl:attribute>
        <xsl:if test="@reason">
             <xsl:attribute name="data-balloon"><xsl:value-of select="@reason"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:locus">
    <xsl:choose>
    <xsl:when test="@target">
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
            <xsl:attribute name="lang">en</xsl:attribute>
            <xsl:attribute name="class">locus<xsl:call-template name="ignore"/></xsl:attribute>
            <xsl:text>(</xsl:text>
                <xsl:apply-templates />
            <xsl:text>)</xsl:text>
        </xsl:element>
    </xsl:when>
    <xsl:otherwise>
        <xsl:element name="span">
            <xsl:attribute name="lang">en</xsl:attribute>
            <xsl:attribute name="class">locus<xsl:call-template name="ignore"/></xsl:attribute>
            <xsl:text>(</xsl:text>
                <xsl:apply-templates />
            <xsl:text>)</xsl:text>
        </xsl:element>
    </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="repeat">
    <xsl:param name="output" />
    <xsl:param name="count" />
    <xsl:if test="$count &gt; 0">
        <xsl:value-of select="$output" />
        <xsl:call-template name="repeat">
            <xsl:with-param name="output" select="$output" />
            <xsl:with-param name="count" select="$count - 1" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template match="x:gap">
    <xsl:element name="span">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">gap<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:attribute name="data-balloon">
            <xsl:text>gap</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity">
                        <xsl:text> of </xsl:text><xsl:value-of select="@quantity"/>
                        <xsl:if test="@unit">
                        <xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                            <xsl:if test="@quantity &gt; '1'">
                                <xsl:text>s</xsl:text>
                            </xsl:if>
                        </xsl:if>
                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:text> of </xsl:text><xsl:value-of select="@extent"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:if test="@reason">
                    <xsl:text> (</xsl:text><xsl:value-of select="@reason"/><xsl:text>)</xsl:text>
                </xsl:if>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="count(./*) &gt; 0">
                <xsl:text>[</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                <xsl:attribute name="class">ignored</xsl:attribute>
                <xsl:text>...</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity &gt; 1">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="output"><xsl:text>..</xsl:text></xsl:with-param>
                            <xsl:with-param name="count" select="@quantity"/>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:variable name="extentnum" select="translate(@extent,translate(@extent,'0123456789',''),'')"/>
                        <xsl:if test="number($extentnum) &gt; 1">
                            <xsl:call-template name="repeat">
                                <xsl:with-param name="output"><xsl:text>..</xsl:text></xsl:with-param>
                                <xsl:with-param name="count" select="$extentnum"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<xsl:template match="x:space">
    <xsl:element name="span">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">space<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:attribute name="data-balloon">
            <xsl:text>space</xsl:text>
            <xsl:if test="@quantity">
                <xsl:text> of </xsl:text><xsl:value-of select="@quantity"/>
                <xsl:if test="@unit">
                <xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                    <xsl:if test="@quantity &gt; '1'">
                        <xsl:text>s</xsl:text>
                    </xsl:if>
                </xsl:if>
            </xsl:if>
            <xsl:if test="@rend">
                <xsl:text> (</xsl:text><xsl:value-of select="@rend"/><xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="count(./*) &gt; 0">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                <xsl:attribute name="class">ignored</xsl:attribute>
                <xsl:text>_</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity &gt; 1">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="output"><xsl:text>_&#x200B;</xsl:text></xsl:with-param>
                            <xsl:with-param name="count" select="@quantity"/>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:variable name="extentnum" select="translate(@extent,translate(@extent,'0123456789',''),'')"/>
                        <xsl:if test="number($extentnum) &gt; 1">
                            <xsl:call-template name="repeat">
                                <xsl:with-param name="output"><xsl:text>_&#x200B;</xsl:text></xsl:with-param>
                                <xsl:with-param name="count" select="$extentnum"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<xsl:template match="x:note">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">note
            <xsl:choose>
                <xsl:when test="@place='above' or @place='top-margin' or @place='left-margin'"> super</xsl:when>
                <xsl:when test="@place='below' or @place='bottom-margin' or @place='right-margin'"> sub</xsl:when>
                <xsl:otherwise> inline</xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="ignore" />
        </xsl:attribute>
        <xsl:attribute name="data-balloon">note
            <xsl:if test="@place"> (<xsl:value-of select="@place"/>)</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:note[@place='foot']">
    <xsl:element name="span">
        <xsl:attribute name="class">hidenote<xsl:call-template name="ignore"/></xsl:attribute>
        <xsl:attribute name="data-balloon">
            <xsl:value-of select="text()"/>
        </xsl:attribute>
        <xsl:element name="span">
            <xsl:attribute name="class">ignored</xsl:attribute>
            <xsl:text>*</xsl:text>
        </xsl:element>
        <xsl:element name="span">
            <xsl:attribute name="style">display: none;</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:element>
</xsl:template>


<xsl:template match="x:hi">
    <xsl:element name="span">
        <xsl:attribute name="class">hi<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:attribute name="data-balloon">marked by <xsl:value-of select="@rend"/></xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:foreign">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:metamark">
    <xsl:element name="span">
        <xsl:attribute name="class">metamark<xsl:call-template name="ignore" /></xsl:attribute>
        <xsl:attribute name="data-balloon">metamark
            <xsl:if test="@function"> (<xsl:value-of select="@function"/>)</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>


<!-- Apparatus items -->

<xsl:template match="x:div2[@type='apparatus']//x:list">
    <xsl:variable name="elid"><xsl:value-of select="ancestor::x:div2[1]/@xml:id"/>-<xsl:value-of select="@type"/></xsl:variable>

    <xsl:element name="li">
        <xsl:attribute name="class">accordion-item</xsl:attribute>
        <xsl:element name="input">
            <xsl:attribute name="class">accordion-item-input</xsl:attribute>
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="name"><xsl:copy-of select="$elid"/></xsl:attribute>    
            <xsl:attribute name="id"><xsl:copy-of select="$elid"/></xsl:attribute>    
            </xsl:element>
        <xsl:element name="label">
            <xsl:attribute name="class">accordion-item-hd</xsl:attribute>
            <xsl:attribute name="for"><xsl:copy-of select="$elid"/></xsl:attribute>
            <xsl:value-of select="@type"/>
            <xsl:element name="span">
            <xsl:attribute name="class">accordion-item-hd-cta</xsl:attribute>
            <xsl:text>&#x25b2;</xsl:text>
            </xsl:element>
        </xsl:element>
        <xsl:element name="div">
            <xsl:attribute name="class">accordion-item-bd</xsl:attribute>
            <xsl:element name="ul">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:element>
</xsl:template>

<xsl:template match="x:list/x:item">
    <xsl:element name="li">
        <xsl:attribute name="class">apparatus2-item</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">quote</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote/x:lg">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">verse-in-quote</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote/x:lg/x:l">
    <xsl:element name="span">
        <xsl:attribute name="class">verseline</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:title">
    <xsl:element name="em">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">title</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!--xsl:template match="@upama-show">
    <xsl:copy>
    <xsl:attribute name="class">upama-show</xsl:attribute>
    <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template-->

<xsl:template match="@*|node()">
    <xsl:copy><xsl:apply-templates select="@* | node()"/></xsl:copy>
</xsl:template>

</xsl:stylesheet>
