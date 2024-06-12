<?xml version="1.0" encoding="UTF-8"?>
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

    <xsl:template match="/tei:TEI/tei:text">
        <text xmlns="http://www.tei-c.org/ns/1.0" xml:lang="eng">
            <xsl:apply-templates/>
        </text>
    </xsl:template>

    <xsl:template match="/tei:TEI/tei:text/tei:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <div type="edition" n="urn:cts:engLit:holinshed.v1.perseus-eng1" xml:lang="eng">
                <xsl:apply-templates/>
            </div>
        </body>
    </xsl:template>


    <xsl:template match="tei:text">
        <floatingText xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </floatingText>
    </xsl:template>
    
    
    <xsl:template match="tei:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            
                <xsl:apply-templates/>
            
        </body>
    </xsl:template>

    <xsl:template match="tei:div1 | tei:div2 | tei:div3 | tei:div4">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            <xsl:attribute name="subtype">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='dedication']">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart" subtype="dedication">
            <xsl:apply-templates />
        </div>
    </xsl:template>



    <xsl:template match="tei:refsDecl">
        <refsDecl xmlns="http://www.tei-c.org/ns/1.0" n="CTS">
            <cRefPattern n="section" matchPattern="(\w+).(\w+).(\w+)"
                replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/tei:div[@n='$1']/tei:div[@n='$2']/tei:div[@n='$3'])">
                <p>This pointer pattern extracts act and scene and line.</p>
            </cRefPattern>
            <cRefPattern n="chapter" matchPattern="(\w+).(\w+)"
                replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/tei:div[@n='$1']/tei:div[@n='$2'])">
                <p>This pointer pattern extracts book and chapter.</p>
            </cRefPattern>
            <cRefPattern n="book" matchPattern="(\w+)"
                replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/tei:div[@n='$1'])">
                <p>This pointer pattern extracts book.</p>
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
        <ab xmlns="http://www.tei-c.org/ns/1.0" type='opener'>
            <xsl:apply-templates />
        </ab>
    </xsl:template>


    <xsl:template match="tei:closer">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type='closer'>
            <xsl:apply-templates />
        </ab>
    </xsl:template>
    
    
    <xsl:template match="tei:salute">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type='salute'>
            <xsl:apply-templates />
        </ab>
    </xsl:template>
    

  
    <xsl:template match="tei:signed">
        <ab xmlns="http://www.tei-c.org/ns/1.0" type='signed'>
            <xsl:apply-templates />
        </ab>
    </xsl:template>
    
    <xsl:template match="tei:argument">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart" subtype="argument">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <quote xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@lang" />
            <xsl:apply-templates select="@rend" />
            <xsl:apply-templates />
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
                <xsl:when test="yes|true">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="tei:gap">
        <gap xmlns="http://www.tei-c.org/ns/1.0" reason="undefined">
            <xsl:apply-templates />
        </gap>
    </xsl:template>
    
</xsl:stylesheet>
