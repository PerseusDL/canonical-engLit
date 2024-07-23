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

    <xsl:template match="tei:text">
        <text xmlns="http://www.tei-c.org/ns/1.0" xml:lang="eng">
            <xsl:apply-templates/>
        </text>
    </xsl:template>

    <xsl:template match="tei:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <div type="edition" n="urn:cts:engLit:shak.perseus-eng1" xml:lang="eng">
                <xsl:apply-templates/>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="tei:language[@id = 'en']">
        <tei:language xmlns="http://www.tei-c.org/ns/1.0" ident="eng"> English </tei:language>
    </xsl:template>

    <xsl:template match="tei:language[@id = 'la']">
        <tei:language xmlns="http://www.tei-c.org/ns/1.0" ident="lat"> Latin </tei:language>
    </xsl:template>

    <xsl:template match="tei:div1 | tei:div2">
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



    <xsl:template match="tei:refsDecl">
        <refsDecl xmlns="http://www.tei-c.org/ns/1.0" n="CTS">
            <cRefPattern n="asl" matchPattern="(\w+).(\w+).(\w+)" 
                replacementPattern="#xpath((//div[@subtype='act' and @n='$1']/div[@subtype='scene' and @n='$2']//lb[@ed='G'])[$3]/parent::*)">
                <p>This pointer pattern extracts act, scene, and line.</p></cRefPattern>
            
            <cRefPattern n="as" matchPattern="(\w+).(\w+)" 
                replacementPattern="#xpath(//div[@subtype='act' and @n='$1']/div[@subtype='scene' and @n='$2'])">
                <p>This pointer pattern extracts act and scene.</p></cRefPattern>
            
            <cRefPattern n="a" matchPattern="(\w+)"
                replacementPattern="#xpath(//div[@subtype='act' and @n='$1'])">
                <p>This pointer pattern extracts act.</p>
            </cRefPattern>
        </refsDecl>
    </xsl:template>

    <xsl:template match="tei:revisionDesc">
        <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
            <change>
                <ab>converted to TEI P5</ab>
            </change>
        </revisionDesc>
    </xsl:template>

    <xsl:template match="tei:reg">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:foreign">
        <foreign xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="@lang"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </foreign>
    </xsl:template>

    <xsl:template match="tei:role">
        <role xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </role>
    </xsl:template>
    
    <xsl:template match="tei:head[@rend='braced']">
        <head  xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </head>
    </xsl:template>
    
    <xsl:template match="tei:lg1 | tei:lg2">
        <lg xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </lg>
    </xsl:template>

</xsl:stylesheet>
