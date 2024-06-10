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
    
    <xsl:template match="tei:editor[@role='editor']">
        <editor xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </editor>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <text xmlns="http://www.tei-c.org/ns/1.0" xml:lang="eng">
            <xsl:apply-templates />
        </text>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <div type="edition" n="urn:cts:engLit:james1.speech1609.perseus-eng1" xml:lang="eng">
                <xsl:apply-templates />
            </div>
        </body>
    </xsl:template>
    
    <xsl:template match="tei:language[@id='en']">
        <tei:language xmlns="http://www.tei-c.org/ns/1.0" ident="eng">
            English
        </tei:language>
    </xsl:template>
    
    <xsl:template match="tei:language[@id='la']">
        <tei:language xmlns="http://www.tei-c.org/ns/1.0" ident="lat">
            Latin
        </tei:language>
    </xsl:template>
    
    <xsl:template match="tei:div1|tei:div2">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            <xsl:attribute name="subtype">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
   
    
    <xsl:template match="tei:refsDecl">
            <refsDecl xmlns="http://www.tei-c.org/ns/1.0" n="CTS">
                <cRefPattern n="section" matchPattern="(\w+).(\w+).(\w+)"
                    replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/tei:div[@n='$1']/tei:div[@n='$2']/tei:div[@n='$3'])">
                    <p>This pointer pattern extracts act and scene and line.</p>
                </cRefPattern>
                <cRefPattern n="chapter" matchPattern="(\w+).(\w+)" replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/tei:div[@n='$1']/tei:div[@n='$2'])">
                    <p>This pointer pattern extracts book and chapter.</p>
                </cRefPattern>
                <cRefPattern n="book" matchPattern="(\w+)" replacementPattern="#xpath(/tei:TEI/tei:text/tei:body/tei:div/tei:div[@n='$1'])">
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

    <xsl:template match="tei:reg">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="tei:foreign">
        <foreign xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="@lang"/>
            </xsl:attribute>
            <xsl:apply-templates />
        </foreign>
    </xsl:template>
    
    <xsl:template match="tei:castList|tei:castGroup">
        <listPerson xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates></xsl:apply-templates>
        </listPerson>
    </xsl:template>
    
    <xsl:template match="tei:castItem">
        <person xmlns="http://www.tei-c.org/ns/1.0">
            
            <xsl:attribute name="xml:id">
                <xsl:value-of select="tei:role/@id"/>
            </xsl:attribute>
            
            <xsl:apply-templates />
        </person>
    </xsl:template>
    
    <xsl:template match="tei:role">
        <persName xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </persName>
    </xsl:template>
    
    <xsl:template match="tei:roleDesc">
        <note xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </note>
    </xsl:template>
</xsl:stylesheet>
