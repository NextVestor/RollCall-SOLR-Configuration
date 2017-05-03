<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0" exclude-result-prefixes="xs fn xsl">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="result">
        <add>
            <xsl:apply-templates/>
        </add>
    </xsl:template>
    <xsl:template match="doc">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="str | date | long | int | bool | float ">
        <xsl:choose>
            <xsl:when test="@name = '_version_' "/>
            <xsl:when test="@name = 'URLSlug_srch' "/>
            <xsl:when test="@name = 'PortraitURL_srch' "/>
            <xsl:when test="@name = 'PositionCategories_srch' "/>
            <xsl:when test="@name = 'CroppedPortraitURL_srch' "/>
            <xsl:when test="@name = 'Name_lookup' "/>
            <xsl:when test="@name = 'FamilyName_phoneme' "/>
            <xsl:when test="@name = 'GivenName_phoneme' "/>
            <xsl:when test="parent::arr">
                <xsl:if test="fn:string-length(fn:normalize-space(.)) &gt; 0">
                    <field name="{parent::arr/@name}">
                        <xsl:value-of select="."/>
                    </field>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="fn:string-length(fn:normalize-space(.)) &gt; 0">
                    <field name="{replace(@name, '_en', '_ss')}">
                        <xsl:value-of select="."/>
                    </field>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="arr">
        <xsl:choose>
            <xsl:when test="@name = 'URLSlug_srch' "/>
            <xsl:when test="@name = 'PortraitURL_srch' "/>
            <xsl:when test="@name = 'PositionCategories_srch' "/>
            <xsl:when test="@name = 'CroppedPortraitURL_srch' "/>
            <xsl:when test="@name = 'Name_lookup' "/>
            <xsl:when test="@name = 'FamilyName_phoneme' "/>
            <xsl:when test="@name = 'GivenName_phoneme' "/>
            <xsl:otherwise>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="lst"/>
    <xsl:template match="@*|node()">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
</xsl:stylesheet>