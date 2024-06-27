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
                <xsl:when test="@id = 'dan'">
                    <xsl:attribute name="ident">dan</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'cy'">
                    <xsl:attribute name="ident">cym</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'it'">
                    <xsl:attribute name="ident">ita</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'nl'">
                    <xsl:attribute name="ident">nld</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'de'">
                    <xsl:attribute name="ident">deu</xsl:attribute>
                </xsl:when>
                <xsl:when test="@id = 'anglosaxon'">
                    <xsl:attribute name="ident">ang</xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </language>
    </xsl:template>

    <xsl:template match="tei:div0 | tei:div1 | tei:div2 | tei:div3 | tei:div4 | tei:div">
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
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            
            <xsl:apply-templates/>
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
    
    <xsl:template match="tei:note">
        <note xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </note>
    </xsl:template>
    
    <xsl:template match="@targOrder | @default | @status | @opt">
        
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <bibl xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </bibl>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </p>
    </xsl:template>
    
    
    <!-- for Onions -->
    <xsl:template match="tei:entryFree">
        <entryFree xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@key">
                    
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates />
        </entryFree>
    </xsl:template>
    
    <xsl:template match="tei:orth">
        <orth xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>
                <xsl:when test="@id">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates />
        </orth>
    </xsl:template>
    
    
    <!-- Template to handle adjacent <quote> and <bibl> -->
    <xsl:template match="tei:quote[following-sibling::*[1][self::tei:bibl]]">
        <cit xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="."/>
            <xsl:copy-of select="following-sibling::*[1][self::tei:bibl]"/>
        </cit>
        <xsl:apply-templates select="following-sibling::*[2]"/>
    </xsl:template>
    
    <!-- Suppress the original <bibl> if it's been enclosed in <cit> -->
    <xsl:template match="tei:bibl[preceding-sibling::*[1][self::tei:quote]]"/>
    
</xsl:stylesheet>
