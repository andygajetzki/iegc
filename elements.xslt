<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
<html>
	<head>
		<title>Periodic Table</title>
<style>
body {
height: 101%;
	margin: 2% 2% 2% 2%;
}
table {
	width: 90%;
	border: medium dotted Silver;
}

table.popup {
padding-bottom:5%;
padding-right:25%;
}

a {
color:black;
}

body {
	margin: 2% 2% 2% 2%;
}


td.element {
		border: thin solid Black;
	background-color: #A6CAF0;
	height: 50px;
}

td.elementcold {
	border: thin solid Black;
	background-color: #A6CAF0;
	height: 50px;

}

td.elementwarm {
	border: thin solid Black;
	background-color: #FFA07A;
	height: 50px;
}

td.elementhot {
	border: thin solid Black;
	background-color: #FF6347;
	height: 50px;
}



td.periodheading {
	background-color:Silver;
}

td.groupheading {
	background-color:Silver;
	text-align: center;
	width: 30px;
}

td.periodheading {
width: 30px;
	text-align: center;
	background-color:Silver;
}
#dek {POSITION:absolute;VISIBILITY:hidden;Z-INDEX:200; width:200px}

</style>
	</head>
	<body>

<DIV ID="dek"></DIV>

<SCRIPT TYPE="text/javascript">
<xsl:comment>

//Pop up information box II (Mike McGrath (mike_mcgrath@lineone.net,  http://website.lineone.net/~mike_mcgrath))
//Permission granted to Dynamicdrive.com to include script in archive
//For this and 100's more DHTML scripts, visit http://dynamicdrive.com

Xoffset=-60;    // modify these values to ...
Yoffset= 20;    // change the popup position.

var old,skn,iex=(document.all),yyy=-1000;

var ns4=document.layers
var ns6=document.getElementById&amp;&amp;!document.all
var ie4=document.all

if (ns4)
skn=document.dek
else if (ns6)
skn=document.getElementById("dek").style
else if (ie4)
skn=document.all.dek.style
if(ns4)document.captureEvents(Event.MOUSEMOVE);
else{
skn.visibility="visible"
skn.display="none"
}
document.onmousemove=get_mouse;

function popup(msg,bak){
var content="&lt;table  class=popup WIDTH=150 BORDER=0 BORDERCOLOR=black CELLPADDING=2 CELLSPACING=0 "+
"BGCOLOR="+bak+"&gt;&lt;TD ALIGN=center&gt;&lt;FONT COLOR=black SIZE=2&gt;"+msg+"&lt;/FONT&gt;&lt;/TD&gt;&lt;/TABLE&gt;";
yyy=Yoffset;
 if(ns4){skn.document.write(content);skn.document.close();skn.visibility="visible"}
 if(ns6){document.getElementById("dek").innerHTML=content;skn.display=''}
 if(ie4){document.all("dek").innerHTML=content;skn.display=''}
}

function get_mouse(e){
var x=(ns4||ns6)?e.pageX:event.x+document.body.scrollLeft;
skn.left=x+Xoffset;
var y=(ns4||ns6)?e.pageY:event.y+document.body.scrollTop;
skn.top=y+yyy;
}

function kill(){
yyy=-1000;
if(ns4){skn.visibility="hidden";}
else if (ns6||ie4)
skn.display="none"
}
</xsl:comment>
</SCRIPT>	
	<xsl:element name="h1">
		Interactive Electronegativity Gradient Chart
	</xsl:element>
	<p>Click on an element to begin. 'W' is a link to the Wikipedia article on the element.</p>
<xsl:element name="table">
<xsl:apply-templates/>
</xsl:element>

<p>Andy Gajetzki (2006)
<br/>Reference: <a href=" http://www.ibiblio.org/xml/examples/periodic_table/allelements.xml">http://www.ibiblio.org/xml/examples/periodic_table/allelements.xml</a></p>
</body>
</html>
</xsl:template>

<xsl:template match="table">
	<xsl:element name="table">
		<xsl:apply-templates/>
	</xsl:element>
</xsl:template>


<xsl:template match="tr">
<xsl:element name="tr">
<xsl:apply-templates/>
</xsl:element>
</xsl:template>
<xsl:template match="b">
<xsl:element name="b">
	<xsl:apply-templates/>
</xsl:element>
</xsl:template>

<xsl:template match="td">
<xsl:element name="td">
<xsl:attribute name="onmouseout">kill()</xsl:attribute>
<xsl:if test="@colspan = not(null)">
	<xsl:attribute name="colspan">
		<xsl:value-of select="@colspan"/>
	</xsl:attribute>
	</xsl:if>
	<xsl:if test="@class = not(null)">
	<xsl:attribute name="class">
		<xsl:value-of select="@class"/>
	</xsl:attribute>
	</xsl:if>
<xsl:apply-templates/>
</xsl:element>
</xsl:template>

<xsl:template match="atom">
<xsl:element name="div">
	<xsl:attribute name="style">width: 100%; height: 100%; background-color:
		<xsl:if test="@color = not(null)">
		<xsl:value-of select="@color"/>
		</xsl:if>
	</xsl:attribute>
	<xsl:attribute name="onclick">window.location = '/andy/chem-iegc/index.php/element/<xsl:value-of select="atomic_number"/>';</xsl:attribute>
	<xsl:attribute name="onmouseover">popup('&lt;tr&gt;&lt;td colspan="2"&gt;&lt;b&gt;<xsl:value-of select="name"/>&lt;/b&gt; - <xsl:value-of select="atomic_number"/>&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Weight:&lt;/td&gt;&lt;td&gt;<xsl:value-of select="atomic_weight"/>&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Electronegativity:&lt;/td&gt;&lt;td&gt;<xsl:value-of select="electronegativity"/>&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td&gt;Electron Configuration&lt;/td&gt;&lt;td&gt;<xsl:value-of select="electron_configuration"/>&lt;/td&gt;&lt;/tr&gt;&lt;tr&gt;&lt;td colspan="2"&gt;Click to view electronegativity map.&lt;/td&gt;&lt;/tr&gt;','#C6F1FF')
	</xsl:attribute>
	

<div style="vertical-align: top; text-align:left;">
<xsl:value-of select="symbol"/>
</div>
<div style="vertical-align: bottom; text-align:left;">
	<xsl:value-of select="atomic_number"/>
</div>
<div style="float:right; vertical-align:bottom;">
	<xsl:element name="a">
		<xsl:attribute name="href">http://en.wikipedia.org/wiki/<xsl:value-of select="name"/></xsl:attribute>
		<small><sub>W</sub></small>
	</xsl:element>
</div>
</xsl:element>
</xsl:template>

<xsl:template match="br">
<xsl:element name="br"/>
</xsl:template>


</xsl:stylesheet>
