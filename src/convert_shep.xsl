<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    This stylesheet processes Marlowe's Passionate Shepherd-->
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
    
    <xsl:template match="tei:extent"></xsl:template>

    <xsl:template match="/tei:TEI/tei:text">
        <text xmlns="http://www.tei-c.org/ns/1.0" xml:lang="eng">
            <xsl:apply-templates/>
        </text>
    </xsl:template>

    <xsl:template match="tei:body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </body>
    </xsl:template>

    
    
    <xsl:template match="tei:front/tei:div[@type='versions']">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="apparatus">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="tei:body/tei:div1">
        <div xmlns="http://www.tei-c.org/ns/1.0" type="textpart">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

   

    <xsl:template match="tei:refsDecl">
        <refsDecl xmlns="http://www.tei-c.org/ns/1.0" n="CTS">
            <cRefPattern n="line" matchPattern="(\w+)"
                replacementPattern="#xpath(//l[@n='$1']" />
        </refsDecl>
    </xsl:template>

    <xsl:template match="tei:revisionDesc">
        <revisionDesc xmlns="http://www.tei-c.org/ns/1.0">
            <list>
                <item>converted to perseus_marlowe.rng</item>
            </list>
        </revisionDesc>
    </xsl:template>

    <xsl:template match="tei:language">
        <language xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:choose>

                <xsl:when test="@id = 'en'">
                    <xsl:attribute name="ident">eng</xsl:attribute>
                </xsl:when>

            </xsl:choose>
            <xsl:apply-templates/>
        </language>
    </xsl:template>
    
    <xsl:template match="tei:l">
        <l xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:value-of select="count(preceding-sibling::tei:l) + 1"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </l>
    </xsl:template>

    <xsl:template match="tei:reg">
        <xsl:apply-templates/>
    </xsl:template>

    

    <!-- Marlowe specific -->

    <xsl:template match="tei:witList">
        <listWit xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
        </listWit>
    </xsl:template>

    <xsl:template match="tei:witness">
        <witness xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@sigil"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </witness>
    </xsl:template>
    
    <xsl:template match="tei:app">
        <app xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </app>
    </xsl:template>
    
    <xsl:template match="tei:lem">
        <lem xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates />
        </lem>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
        <rdg xmlns="http://www.tei-c.org/ns/1.0">
        <xsl:attribute name="wit">
            <xsl:for-each select="tokenize(@wit, ' ')">
                <xsl:value-of select="concat('#', .)"/>
                <xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
            </xsl:for-each>
        </xsl:attribute>
        <xsl:apply-templates />
        </rdg>
    </xsl:template>
   

</xsl:stylesheet>
