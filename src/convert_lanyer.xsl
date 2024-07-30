<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    This stylesheet processes Lanyer, Cooke-Ham -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="tei:teiHeader">
        <teiHeader xmlns="http://www.tei-c.org/ns/1.0" xml:lang="eng">
            <xsl:apply-templates/>
        </teiHeader>
    </xsl:template>

    <xsl:template match="tei:editor[@role = 'editor']">
        <editor xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </editor>
    </xsl:template>
    
    <xsl:template match="tei:publicationStmt">
        <publicationStmt xmlns="http://www.tei-c.org/ns/1.0">
            <publisher>Trustees of Tufts University</publisher>
            <pubPlace>Medford, MA</pubPlace>
            <authority>Perseus Project</authority>
            <date type="release" when="2001" cert="high">Perseus 3.0</date>
            <idno type="filename">lanyer.cookeham.perseus-eng1.xml</idno>
            <availability>
                <licence target="https://creativecommons.org/licenses/by-sa/4.0/">Available under a Creative
                    Commons Attribution-ShareAlike 4.0 International License</licence>
            </availability>
        </publicationStmt>
    </xsl:template>

    <xsl:template match="/tei:TEI/tei:text">
        <text xmlns="http://www.tei-c.org/ns/1.0" xml:lang="eng">
            <xsl:apply-templates/>
        </text>
    </xsl:template>

    <xsl:template match="tei:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <div type="edition" xml:lang="eng"
                n="urn:cts:engLit:lanyer.cookeham.perseus-eng1">
            <xsl:apply-templates/>
            </div>
        </body>
    </xsl:template>
    
    <xsl:template match="tei:p/tei:text">
        <floatingText xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </floatingText>
    </xsl:template>
    
    <xsl:template match="tei:div1">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:attribute name="subtype">
                        <xsl:value-of select="@type"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@n">
                    <xsl:attribute name="n">
                        <xsl:value-of select= "position() - 1"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:text/tei:body/tei:div[@type='part']">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:attribute name="subtype">
                        <xsl:text>part</xsl:text>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@n">
                    <xsl:attribute name="n">
                        <xsl:value-of select="count(preceding-sibling::tei:div[@type='part']) + 1"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:div[@type='part']/tei:div[@type='subpart']">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:attribute name="subtype">
                        <xsl:value-of select="@type"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@n">
                    <xsl:attribute name="n">
                        <xsl:value-of select="count(preceding-sibling::tei:div[@type='subpart']) +1 "/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            
                
                    <xsl:attribute name="subtype">
                        <xsl:text>subsubpart</xsl:text>
                    </xsl:attribute>
            <xsl:attribute name="n">
                <xsl:value-of select="count(preceding-sibling::tei:div) +1 "/>
            </xsl:attribute>
                
            
            
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--  
    <xsl:template match="tei:div[@type='dedication']">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart" subtype="dedication">
            <xsl:apply-templates />
        </div>
    </xsl:template>


    <xsl:template match="tei:div[@type='epistle']">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart" subtype="epistle">
            <xsl:apply-templates />
        </div>
    </xsl:template>
  -->
    <xsl:template match="tei:refsDecl">
        <refsDecl xmlns="http://www.tei-c.org/ns/1.0" n="CTS">
            <cRefPattern n="section" matchPattern="(\w+)"
                replacementPattern="#xpath(//tei:l[@n='$1')">
                <p>This pointer pattern extracts line.</p>
            </cRefPattern>
            
            
        </refsDecl>
    </xsl:template>

    <xsl:template match="tei:revisionDesc">
        <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
            <change>
                <ab>converted to EpiDoc</ab>
            </change>
        </revisionDesc>
    </xsl:template>

    <xsl:template match="tei:language">
        <language xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@id = 'greek'">
                    <xsl:attribute name="ident">grc</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'la'">
                    <xsl:attribute name="ident">lat</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'en'">
                    <xsl:attribute name="ident">eng</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'fr'">
                    <xsl:attribute name="ident">fra</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'de'">
                    <xsl:attribute name="ident">deu</xsl:attribute>
                </xsl:when>
                
                <xsl:when test="@id = 'it'">
                    <xsl:attribute name="ident">ita</xsl:attribute>
                </xsl:when>
                
            </xsl:choose>
            <xsl:apply-templates/>
        </language>
    </xsl:template>



    <xsl:template match="tei:titlePage">
        <xsl:comment>
            titlePage removed
        </xsl:comment>
    </xsl:template>

    <xsl:template match="tei:trailer">
        <xsl:comment>trailer omitted</xsl:comment>
    </xsl:template>

    <xsl:template match="tei:opener">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type="opener">
            <xsl:apply-templates/>
        </ab>
    </xsl:template>


    <xsl:template match="tei:closer">
        <note xmlns="http://www.tei-c.org/ns/1.0" type="closer">
            <xsl:apply-templates/>
        </note>
    </xsl:template>


    <xsl:template match="tei:salute">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type="salute">
            <xsl:apply-templates/>
        </ab>
    </xsl:template>


    <xsl:template match="tei:dateline">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type="dateline">
            <xsl:apply-templates/>
        </ab>
    </xsl:template>

    <xsl:template match="tei:signed">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type="signed">
            <xsl:apply-templates/>
        </ab>
    </xsl:template>

    <xsl:template match="tei:argument">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart" subtype="argument">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:quote">
        <quote xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@lang"/>
            <xsl:apply-templates select="@rend"/>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>

    <xsl:template match="@lang">
        <xsl:attribute name="xml:lang">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@anchored">
        <xsl:attribute name="anchored">
            <xsl:choose>
                <xsl:when test="yes">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="tei:gap">
        <gap xmlns="http://www.tei-c.org/ns/1.0" reason="undefined">
            <xsl:apply-templates/>
        </gap>
    </xsl:template>

    <xsl:template match="tei:xref">
        <ref xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </ref>
    </xsl:template>

    <xsl:template match="tei:unclear[tei:foreign]">
        <unclear xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:lang">
                <xsl:apply-templates select="./tei:foreign/@lang"/>
            </xsl:attribute>
            <xsl:value-of select="./tei:foreign"/>
        </unclear>
    </xsl:template>

    <xsl:template match="tei:foreName">
        <forename xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </forename>
    </xsl:template>
    
    <xsl:template match="tei:date">
        <date xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@value">
                    <xsl:attribute name="when-custom">
                        <xsl:value-of select="@value"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates />
        </date>
    </xsl:template>
    
    <xsl:template match="tei:dateRange">
        <date xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </date>
    </xsl:template>
    
    <xsl:template match="tei:mentioned">
        <mentioned  xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates />
        </mentioned>
    </xsl:template>
    
    <xsl:template match="tei:reg">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="tei:anchor">
        <anchor xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates />
        </anchor>
    </xsl:template>
    
    <xsl:template match="tei:lg/tei:l">
        <l xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="count(./preceding-sibling::*[position()]) + 1"/>
            </xsl:attribute>
            <xsl:apply-templates />
        </l>
    </xsl:template>
    
    <xsl:template match="tei:milestone">
        
    </xsl:template>

</xsl:stylesheet>
