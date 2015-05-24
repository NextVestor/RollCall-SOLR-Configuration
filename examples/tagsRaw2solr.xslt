<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xsl xs fn xsi">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
		<xsl:template match="/" >
			<xsl:apply-templates />
		</xsl:template>
		<xsl:template match="doc" >
			<xsl:copy>
				<xsl:apply-templates />
			</xsl:copy>
		</xsl:template>
		<xsl:template match="add" >
			<xsl:copy>
				<xsl:apply-templates />
			</xsl:copy>
		</xsl:template>	
		<xsl:template match="id" >
			<field name="id"><xsl:value-of select="." /></field>
		
		</xsl:template>
		<xsl:template match="Category" >
			<field name="Category"><xsl:value-of select="." /></field>
		
		</xsl:template>			
		<xsl:template match="CQRCid" >
			<field name="CQRCid"><xsl:value-of select="." /></field>
		
		</xsl:template>		
				<xsl:template match="Tag" >
			<field name="Tag"><xsl:value-of select="." /></field>
		
		</xsl:template>				
	
</xsl:stylesheet>
