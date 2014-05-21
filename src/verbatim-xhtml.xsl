<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:verbatim="http://www.corbas.co.uk/ns/verbatim" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs verbatim xd">
	
	<xsl:import href="verbatim-base.xsl"/>
		
		
	<xd:doc scope="stylesheet">
			<xd:desc>
				
				<xd:b>
					<xd:b>XML Verbatim XHTML Renderer</xd:b>
				</xd:b>
				
				<xd:p>
					<xd:i>Version 2.0</xd:i>
				</xd:p>
				<xd:p>Contributors: Nic Gibson</xd:p>
				<xd:p>Copyright 2014 Corbas Consulting Ltd</xd:p>
				<xd:p>Contact: corbas@corbas.co.uk</xd:p>
				
				<xd:p>Rewritten as a layer above the base renderer.</xd:p>
				
				<xd:p>
					<xd:i>Version 1.0</xd:i>
				</xd:p>
				<xd:p>Contributors: Nic Gibson</xd:p>
				<xd:p>Copyright 2013 Corbas Consulting Ltd</xd:p>
				<xd:p>Contact: corbas@corbas.co.uk</xd:p>
				
				<xd:p>XML to "escaped" xhtml with configurability. Generates XHTML with styling and
					override options through modularity. </xd:p>
				
				<xd:p>
					<xd:b>License Terms</xd:b>
				</xd:p>
				
				<xd:p>This program and accompanying files are copyright 2013, 2014 Corbas Consulting
					Ltd.</xd:p>
				
				<xd:p>This program is free software: you can redistribute it and/or modify it under the
					terms of the GNU General Public License as published by the Free Software
					Foundation, either version 3 of the License, or (at your option) any later
					version.</xd:p>
				
				<xd:p>This program is distributed in the hope that it will be useful, but WITHOUT ANY
					WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
					PARTICULAR PURPOSE. See the GNU General Public License for more details.</xd:p>
				
				<xd:p>You should have received a copy of the GNU General Public License along with this
					program. If not, see http://www.gnu.org/licenses/.</xd:p>
				
				<xd:p>
					<xd:b>Corbas Consulting Clients and Customers</xd:b>
				</xd:p>
				
				<xd:p>If your organisation or company are a customer or client of Corbas Consulting Ltd
					you may be able to use and/or distribute this software under a different license. If
					you are not aware of any such agreement and wish to agree other license terms you
					must contact Corbas Consulting Ltd by email at corbas@corbas.co.uk.</xd:p>
				
			</xd:desc>
		
			<xd:param name="verbatim:element-class">The CSS class name to be applied to spans wrapping
			entire elements. Defaults to <xd:i>verbatim-element</xd:i></xd:param>
			
		</xd:doc>
		
	<xsl:output method="xhtml" omit-xml-declaration="yes" indent="no"/>

	<xsl:param name="verbatim:element-class" select="'verbatim-element'"/>
	
	<xd:doc><xd:desc><xd:p>Wrap elements in element spans.</xd:p></xd:desc></xd:doc>
	<xsl:template match="*" mode="verbatim:node">
		<span class="{$verbatim:element-class}"><xsl:next-match/></span>
	</xsl:template>

	<xd:doc>
		<xd:desc><xd:p>Output the namespace prefix for an element that
		actually has one.</xd:p></xd:desc>
	</xd:doc>
	<xsl:template match="*[not(local-name() = name())]" mode="verbatim:ns-prefix">
		<span class="verbatim-element-nsprefix">
			<xsl:next-match/>
		</span>
	</xsl:template>

		
	<xd:doc>
		<xd:desc><xd:p>Output the element name itself</xd:p></xd:desc>
	</xd:doc>
	<xsl:template match="*" mode="verbatim:name">
		<span class="verbatim-element-name"><xsl:next-match/></span>
	</xsl:template>


	
	<xd:doc>
		<xd:desc>
			<xd:p>Renders an individual namespace declaration.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="*" mode="verbatim:render-ns-declaration">
		<span class="verbatim-ns-name">
			<xsl:next-match/>
		</span>
	</xsl:template>
	
	<xd:doc>
		<xd:desc>Generate a namespace declaration for those elements where the parent
		is in a namespace but the current node isn't</xd:desc>
	</xd:doc>
	<xsl:template match="*[not(namespace-uri())][namespace-uri(parent::*)]" mode="verbatim:ns-declarations">
		<span class="verbatim-ns-name"><xsl:text> xmlns=""</xsl:text></span>
	</xsl:template>
	

	<xd:doc>
		<xd:desc>Render an attribute name</xd:desc>
	</xd:doc>
	<xsl:template match="@*" mode="verbatim:name">
		<span class="verbatim-attr-name"><xsl:next-match/></span>
	</xsl:template>
	

	<xd:doc>
		<xd:desc>Render an attribute value</xd:desc>
	</xd:doc>
	<xsl:template match="@*" mode="verbatim:attribute-value">
		<span class="verbatim-attr-content">
			<xsl:next-match/>
		</span>		
	</xsl:template>
	
	<xd:doc>
		<xd:desc><xd:p>Process text. Potentially
		replaces entities and restricts the amount of output text. Newlines
		are replaced with breaks.</xd:p></xd:desc>
	</xd:doc>
	<xsl:template match="text()" mode="verbatim:node">

		<span class="verbatim-text"><xsl:next-match/></span>

	</xsl:template>


	<xd:doc>
		<xd:desc><xd:p>Output the body of a comment wrapped in a span</xd:p></xd:desc>
	</xd:doc>
	
	<xsl:template match="comment()" mode="verbatim:comment-content">
		<span class="verbatim-comment">
			<xsl:next-match/>
		</span>		
	</xsl:template>

	<xd:doc>
		<xd:desc><xd:p>Output processing instructions body, wrapped in a span.</xd:p></xd:desc>
	</xd:doc>
	<xsl:template match="processing-instruction()" mode="verbatim:content">
			<span class="verbatim-pi-content">
				<xsl:next-match/>
			</span>
	</xsl:template>

	<xd:doc>
		<xd:desc><xd:p>Output processing instructions name, wrapped in a span.</xd:p></xd:desc>
	</xd:doc>
	<xsl:template match="processing-instruction()" mode="verbatim:name">
		<span class="verbatim-pi-name">
			<xsl:next-match/>
		</span>
	</xsl:template>
	


	<xd:doc>
		<xd:desc>
			<xd:p>Write out a break as appropriate for the output type - br node in this case.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="node()" mode="verbatim:break">
		<br/>		
	</xsl:template>
	
	<xd:doc>
		<xd:desc>
			<xd:p>Write out an indent wrapped in a span</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="node()" mode="verbatim:indent">
		<span class="indent"><xsl:next-match/></span>
	</xsl:template>
</xsl:stylesheet>
