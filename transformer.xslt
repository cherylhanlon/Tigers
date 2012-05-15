<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://schemas.microsoft.com/developer/msbuild/2003"
                xmlns:ms="http://schemas.microsoft.com/developer/msbuild/2003"
                >

  <xsl:output indent="yes" method="xml" />
  
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="ms:ItemGroup/ms:ProjectReference">
    <xsl:element name="Reference">
      <xsl:attribute name="Include">
        <xsl:value-of select="ms:Name" />
        <xsl:text>.dll</xsl:text>
      </xsl:attribute>
      <xsl:element name="SpecificVersion">
        <xsl:text>false</xsl:text>
      </xsl:element>      
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
