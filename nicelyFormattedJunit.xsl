<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:template match="/testsuite">
    <xsl:for-each-group select="testcase" group-by="@classname">
      <xsl:sort select="current-grouping-key()" data-type="text" order="descending"/>
      <xsl:value-of select="current-grouping-key()"/>
      <xsl:text>
</xsl:text>
<xsl:for-each select="current-group()">
      <xsl:text>-  </xsl:text><xsl:value-of select="@name"/>
      <xsl:text>
</xsl:text>
    </xsl:for-each>
      <xsl:text>
</xsl:text>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="/testsuiteWithTimeIncluded">
    <xsl:for-each-group select="testcase" group-by="@classname">
      <xsl:value-of select="current-grouping-key()"/>
      <xsl:text>
</xsl:text>
<xsl:for-each select="current-group()">
      <xsl:value-of select="@name"/>, <xsl:value-of select="@time"/>
      <xsl:text>
</xsl:text>
    </xsl:for-each>
      <xsl:text>
</xsl:text>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="testcase">
    <xsl:text>
      ...
    </xsl:text>
    <xsl:value-of select="@name" />
  </xsl:template>

  <xsl:template match="system-out">
    <xsl:value-of select="." />
  </xsl:template>

  <xsl:template match="system-err">
    <xsl:value-of select="." />
  </xsl:template>

</xsl:stylesheet>
