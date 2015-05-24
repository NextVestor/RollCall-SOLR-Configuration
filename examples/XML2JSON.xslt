<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
		<xsl:variable name="quote">"</xsl:variable>
		<xsl:value-of select=" '{' "/>
		<xsl:apply-templates/>
		<xsl:value-of select=" concat( $quote, 'commit', $quote, ': {}' , '}' ) "/>
	</xsl:template>
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="add" >
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="doc">
		<xsl:variable name="quote">"</xsl:variable>
		<xsl:variable name="OpenCurlyBrace">{</xsl:variable>
		<xsl:variable name="CloseCurlyBrace">}</xsl:variable>
		<xsl:value-of select="fn:concat( $quote, 'add', $quote, ':', $OpenCurlyBrace )"/>		
		<xsl:value-of select="fn:concat( $quote, name(), $quote, ':', $OpenCurlyBrace )"/>
		<xsl:apply-templates select="@*|node()"/>
		<xsl:value-of select="$CloseCurlyBrace"/><xsl:value-of select="$CloseCurlyBrace"/>,
	</xsl:template>
	<xsl:template match="field">
		<xsl:variable name="quote">"</xsl:variable>

		<xsl:choose>
			<xsl:when test="not(@name = following-sibling::field/@name) and not(@name = preceding-sibling::field/@name)">
				<xsl:value-of select="fn:concat($quote, @name, $quote, ':', $quote, text(), $quote, ',' )"/>					
			</xsl:when>		
			<xsl:when test="@name = following-sibling::field/@name and not(@name = preceding-sibling::field/@name) ">
				<xsl:value-of select="fn:concat($quote, @name, $quote, ':[', $quote, text(), $quote, ',' )"/>				
			</xsl:when>
			<xsl:when test="@name = preceding-sibling::field/@name and not(@name = following-sibling::field/@name) ">
				<xsl:value-of select="fn:concat( $quote, text(), $quote, '],' )"/>				
			</xsl:when>			
			<xsl:otherwise><xsl:value-of select="fn:concat( $quote, text(), $quote, ',' )"/></xsl:otherwise>
			
			</xsl:choose>

						
	</xsl:template>
	<xsl:template match="field[not(following-sibling::field)]" >
		<xsl:variable name="quote">"</xsl:variable>

		<xsl:choose>
			<xsl:when test="not(@name = following-sibling::field/@name) and not(@name = preceding-sibling::field/@name)">
				<xsl:value-of select="fn:concat($quote, @name, $quote, ':', $quote, text(), $quote )"/>					
			</xsl:when>		
			<xsl:when test="@name = following-sibling::field/@name and not(@name = preceding-sibling::field/@name) ">
				<xsl:value-of select="fn:concat($quote, @name, $quote, ':[', $quote, text(), $quote, ',' )"/>				
			</xsl:when>
			<xsl:when test="@name = preceding-sibling::field/@name and not(@name = following-sibling::field/@name) ">
				<xsl:value-of select="fn:concat( $quote, text(), $quote, ']' )"/>				
			</xsl:when>			
			<xsl:otherwise><xsl:value-of select="fn:concat( $quote, text(), $quote, ',' )"/></xsl:otherwise>
			
			</xsl:choose>	
	
	</xsl:template>
	<xsl:template match="processing-instruction()|comment()"/>
</xsl:stylesheet>
