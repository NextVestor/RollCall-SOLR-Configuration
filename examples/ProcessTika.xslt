<xsl:stylesheet version="1.0" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="html xsl xs fn">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:param name="fileLocation" />
	<xsl:param name="rootDirectory" select="'photos/'" />
    <xsl:param name="UploadDate" select="''"/>
	<xsl:variable name="filename" >
        <xsl:call-template name="GetLastSegment">
            <xsl:with-param name="value" select="$fileLocation" />
            <xsl:with-param name="separator" select="'/'" />
        </xsl:call-template>
    </xsl:variable>
	<xsl:template match="/">
		<add>
			<doc>
				<field name="id"><xsl:value-of select="$filename" /></field>
				<field name="PhotoFileName"><xsl:value-of select="$filename" /></field>
				<field name="PhotoLocation" ><xsl:value-of select="concat($rootDirectory, substring-after($fileLocation, $rootDirectory))" /></field>
                <field name="UploadDate"><xsl:value-of select="$UploadDate" /></field>
				<xsl:apply-templates select="//html:meta" />
			</doc>
		</add>
	</xsl:template>
	<xsl:template match="html:meta[@name = 'Image Description' or @name = 'description' or @name='dc:description' ] ">
		<xsl:choose>
			<xsl:when test="@name = 'Image Description' ">
				<field name="Body">
					<xsl:value-of select="@content"/>
				</field>
			</xsl:when>
			<xsl:when test="@name = 'description' ">
				<xsl:choose>
					<xsl:when test="following-sibling::html:meta[@name = 'Image Description'] or  preceding-sibling::html:meta[@name = 'Image Description']"/>
					<xsl:otherwise >
						<field name="Body">
							<xsl:value-of select="@content"/>
						</field>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@name = 'dc:description' ">
				<xsl:choose>
					<xsl:when test="following-sibling::html:meta[@name = 'Image Description'] or  preceding-sibling::html:meta[@name = 'Image Description'] or following-sibling::html:meta[@name = 'description'] or  preceding-sibling::html:meta[@name = 'description'] "/>
					<xsl:otherwise >
						<field name="Body">
							<xsl:value-of select="@content"/>
						</field>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>			
		</xsl:choose>
	</xsl:template>	
	<xsl:template match="html:meta[@name = 'Artist' or @name='Author' or @name='Writer/Editor' or @name='creator' or @name='Caption Writer/Editor']  ">
		<field name="Contributor">
			<xsl:value-of select="@name"/>|<xsl:value-of select="@content"/>
		</field>
	</xsl:template>
	<xsl:template match="html:meta[@name = 'Keywords' or @name='Subject' or @name='dc:subject' or @name='meta:keyword']  ">
		<field name="Tag">
			<xsl:value-of select="@name"/>|<xsl:value-of select="@content"/>
		</field>
	</xsl:template>
	
	
	<xsl:template match="html:meta" >
		<xsl:variable name="fieldName"><xsl:call-template name="processFieldName"><xsl:with-param name="fieldName" select="@name" /></xsl:call-template></xsl:variable>
		<field name="{concat($fieldName, '_en')}">
			<xsl:value-of select="@content"/>
		</field>
		<field name="FieldNames" ><xsl:value-of select="concat($fieldName, '_en')" /></field>
		<field name="SourceFieldNames" ><xsl:value-of select="@name" /></field>
		
	</xsl:template>
	<xsl:template name="processFieldName" >
		<xsl:param name="fieldName" />
		<xsl:value-of select="translate($fieldName, ' /?~!@#$%^&lt;&gt;®&amp;', '' )" />		
	</xsl:template>
		<xsl:template name="GetLastSegment">
		<xsl:param name="value"/>
		<xsl:param name="separator" select=" '.' "/>
		<xsl:choose>
			<xsl:when test="contains($value, $separator)">
				<xsl:call-template name="GetLastSegment">
					<xsl:with-param name="value" select="substring-after($value, $separator)"/>
					<xsl:with-param name="separator" select="$separator"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
