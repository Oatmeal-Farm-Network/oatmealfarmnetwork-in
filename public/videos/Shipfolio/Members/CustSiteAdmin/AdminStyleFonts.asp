<!DOCTYPE HTML >
<html>
<head>
<!--#Include file="Adminglobalvariables.asp"--> 
<title>The Andresen Group Content Management System</title>
<base target="_top">
 <% Page = "Editwebsite" %>
 <link rel="stylesheet" type="text/css" href="/administration/AdminFramestyle.css">
	
</head>
<body >
<table width = "970" height = "450" bgcolor = "white" border = "0" cellspacing = "0" cellpadding = "0"><tr><td>
<% 
sql = "select * from SiteDesignTemp where peopleid= " & PeopleID

		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then

Header = rs("Header")

logo = rs("Logo")
    
MenuBackgroundColor = rs("MenuBackgroundColor")
str1 = MenuBackgroundColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	MenuBackgroundColor= Replace(str1,  str2, "")
End If 
PageBackgroundColor = rs("PageBackgroundColor")
str1 = PageBackgroundColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageBackgroundColor= Replace(str1,  str2, "")
End If 
FooterBackgroundColor = rs("FooterColor")
 
 MenuBackgroundImage = rs("MenuBackgroundImage")
PageBackgroundImage = rs("PageBackgroundImage")
FooterBackgroundImage = rs("FooterImage")



DBTitleColor = rs("TitleColor")
DBTitleFont = rs("TitleFont")
DBTitleSize = rs("TitleSize")
DBTitleAlign = rs("TitleAlign")
DBTitleWeight = rs("TitleWeight")
DBTitleItalics = rs("TitleItalics")

DBMenuColor = rs("MenuColor")
str1 = DBMenuColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	DBMenuColor= Replace(str1,  str2, "")
End If 

DBMenuFontMouseOverColor = rs("MenuFontMouseOverColor")
DBMenuSize = rs("MenuSize")
DBMenuFont = rs("MenuFont")
DBMenuAlign = rs("MenuAlign")
DBMenuWeight = rs("MenuWeight")
DBMenuItalics = rs("MenuItalics")
DBMenuHyperlinkColor = rs("MenuHyperlinkColor")
str1 = DBMenuHyperlinkColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	DBMenuHyperlinkColor= Replace(str1,  str2, "")
End If 


DBPageTextColor = rs("PageTextColor")
DBPageTextFontsize = rs("PageTextFontSize")
DBPageTextFont = rs("PageTextFont")
DBPageTextHyperlinkColor = rs("PageTextHyperlinkColor")
DBPageTextMouseOverColor = rs("PageTextMouseOverColor")
DBPageTextAlign = rs("PageTextAlign")
DBPageTextWeight = rs("PageTextWeight")
DBPageTextItalics = rs("PageTextItalics")

DBFooterColor = rs("FooterColor")
DBFooterTextColor = rs("FooterTextColor")
DBFooterTextSize = rs("FooterTextSize")
DBFooterTextFont = rs("FooterTextFont")
str1 = DBFooterTextFont
str2 = "'"
If InStr(str1,str2) > 0 Then
	DBFooterTextFont= Replace(str1,  str2, "")
End If 


DBFooterHyperlinkColor = rs("FooterHyperlinkColor")
str1 = DBFooterHyperlinkColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	DBFooterHyperlinkColor= Replace(str1,  str2, "")
End If 

DBFooterMouseOverColor = rs("FooterMouseOverColor")
DBFooterAlign = rs("FooterAlign")
DBFooterWeight = rs("FooterWeight")
DBFooterItalics = rs("FooterItalics")
DBFooterImage = rs("FooterImage")

DBH2Color = rs("H2Color")
DBH2size = rs("H2Size")
DBH2Font = rs("H2Font")
DBH2HyperlinkColor = rs("H2HyperlinkColor")
DBH2MouseOverColor = rs("H2MouseOverColor")
DBH2Align = rs("H2Align")
DBH2Weight = rs("H2Weight")
DBH2Italics = rs("H2Italics")

DBH3Color = rs("H3Color")
DBH3size = rs("H3Size")
DBH3Font = rs("H3Font")
DBH3HyperlinkColor = rs("H3HyperlinkColor")
DBH3MouseOverColor = rs("H3MouseOverColor")
DBH3Align = rs("H3Align")
DBH3Weight = rs("H3Weight")
DBH3Italics = rs("H3Italics")

DBH4Color = rs("H4Color")
DBH4size = rs("H4Size")
DBH4Font = rs("H4Font")
DBH4HyperlinkColor = rs("H4HyperlinkColor")
DBH4MouseOverColor = rs("H4MouseOverColor")
DBH4Align = rs("H4Align")
DBH4Weight = rs("H4Weight")
DBH4Italics = rs("H4Italics")



TitleColor=Request.Form("TitleColor" )
If Len(TitleColor) > 1  then
Else
TitleColor = DBTitleColor
End If


TitleFont=Request.Form("TitleFont" )
If Len(TitleFont) > 1  then
Else
TitleFont= DBTitleFont
End If

TitleSize=Request.Form("TitleSize" )
If Len(TitleSize) > 1  then
Else
TitleSize= DBTitleSize
End If



TitleAlign=Request.Form("TitleAlign" )
If Len(TitleAlign) > 1  then
Else
TitleAlign= DBTitleAlign
End If

TitleWeight=Request.Form("TitleWeight" )
If Len(TitleWeight) > 1  then
Else
TitleWeight= DBTitleWeight
End If

TitleItalics=Request.Form("TitleItalics" )
If Len(TitleItalics) > 1  then
Else
TitleItalics= DBTitleItalics
End If

MenuColor=Request.Form("MenuColor" )
If Len(MenuColor) > 1  then
Else
MenuColor= DBMenuColor
End If



MenuHyperlinkColor=Request.Form("MenuHyperlinkColor" )
If Len(MenuHyperlinkColor) > 1  then
Else
MenuHyperlinkColor= DBMenuHyperlinkColor
End If



MenuFontMouseOverColor=Request.Form("MenuFontMouseOverColor" )
If Len(MenuFontMouseOverColor) > 1  then
Else
MenuFontMouseOverColor= DBMenuFontMouseOverColor
End If

MenuSize=Request.Form("MenuSize" )
If Len(MenuSize) > 1  then
Else
MenuSize= DBMenuSize
End If

MenuFont=Request.Form("MenuFont" )
If Len(MenuFont) > 1  then
Else
MenuFont= DBMenuFont
End If

MenuAlign=Request.Form("MenuAlign" )
If Len(MenuAlign) > 1  then
Else
MenuAlign= DBMenuAlign
End If

MenuWeight=Request.Form("MenuWeight" )
If Len(MenuWeight) > 1  then
Else
MenuWeight= DBMenuWeight
End If

MenuItalics=Request.Form("MenuItalics" )
If Len(MenuItalics) > 1  then
Else
MenuItalics= DBMenuItalics
End If



PageTextColor=Request.Form("PageTextColor" )
If Len(PageTextColor) > 1  then
Else
PageTextColor= DBPageTextColor
End If

PageTextFontsize=Request.Form("PageTextFontsize" )
If Len(PageTextFontsize) > 1  then
Else
PageTextFontsize= DBPageTextFontsize
End If

PageTextFont=Request.Form("PageTextFont" )
If Len(PageTextFont) > 1  then
Else
PageTextFont= DBPageTextFont
End If

PageTextHyperlinkColor=Request.Form("PageTextHyperlinkColor" )
If Len(PageTextHyperlinkColor) > 1  then
Else
PageTextHyperlinkColor= DBPageTextHyperlinkColor
End If

PageTextMouseOverColor=Request.Form("PageTextMouseOverColor" )
If Len(PageTextMouseOverColor) > 1  then
Else
PageTextMouseOverColor= DBPageTextMouseOverColor
End If

PageTextAlign =Request.Form("PageTextAlign" )
If Len(PageTextAlign) > 1  then
Else
PageTextAlign= DBPageTextAlign
End If

PageTextWeight =Request.Form("PageTextWeight" )
If Len(PageTextWeight) > 1  then
Else
PageTextWeight= DBPageTextWeight
End If

PageTextItalics =Request.Form("PageTextItalics" )
If Len(PageTextItalics) > 1  then
Else
PageTextItalics= DBPageTextItalics
End If

FooterColor=Request.Form("FooterColor" )
If Len(FooterColor) > 1  then
Else
FooterColor= DBFooterColor
End If

FooterTextColor =Request.Form("FooterTextColor" )
If Len(FooterTextColor) > 1  then
Else
FooterTextColor= DBFooterTextColor
End If

FooterTextSize=Request.Form("FooterTextSize" )
If Len(FooterTextSize) > 1  then
Else
FooterTextSize= DBFooterTextSize
End If

FooterTextFont =Request.Form("FooterTextFont" )
If Len(FooterTextFont) > 1  then
Else
FooterTextFont= DBFooterTextFont
End If

FooterHyperlinkColor=Request.Form("FooterHyperlinkColor" )
If Len(FooterHyperlinkColor) > 1  then
Else
FooterHyperlinkColor= DBFooterHyperlinkColor
End If

FooterMouseOverColor =Request.Form("FooterMouseOverColor" )
If Len(FooterMouseOverColor) > 1  then
Else
FooterMouseOverColor= DBFooterMouseOverColor
End If

FooterAlign =Request.Form("FooterAlign" )
If Len(FooterAlign) > 1  then
Else
FooterAlign= DBFooterAlign
End If

FooterWeight =Request.Form("FooterWeight" )
If Len(FooterWeight) > 1  then
Else
FooterWeight= DBFooterWeight
End If


FooterItalics =Request.Form("FooterItalics" )
If Len(FooterItalics) > 1  then
Else
FooterItalics= DBFooterItalics
End If

FooterImage=Request.Form("FooterImage" )
If Len(FooterImage) > 1  then
Else
FooterImage= DBFooterImage
End If



H2Color =Request.Form("H2Color" )
If Len(H2Color) > 1  then
Else
H2Color= DBH2Color
End If

H2size =Request.Form("H2size" )
If Len(H2size) > 1  then
Else
H2size= DBH2size
End If

H2Font =Request.Form("H2Font" )
If Len(H2Font) > 1  then
Else
H2Font= DBH2Font
End If

H2HyperlinkColor =Request.Form("H2HyperlinkColor" )
If Len(H2HyperlinkColor) > 1  then
Else
H2HyperlinkColor= DBH2HyperlinkColor
End If

H2MouseOverColor = Request.Form("H2MouseOverColor" )
If Len(H2MouseOverColor) > 1  then
Else
H2MouseOverColor= DBH2MouseOverColor
End If

H2Align = Request.Form("H2Align" )
If Len(H2Align) > 1  then
Else
H2Align = DBH2Align
End If

H2Weight= Request.Form("H2Weight" )
If Len(H2Weight) > 1  then
Else
H2Weight= DBH2Weight
End If


H2Italics = Request.Form("H2Italics" )
If Len(H2Italics) > 1  then
Else
H2Italics= DBH2Italics
End If

H3Color = Request.Form("H3Color" )
If Len(H3Color) > 1  then
Else
H3Color= DBH3Color
End If


H3size = Request.Form("H3size" )
If Len(H3size) > 1  then
Else
H3size= DBH3size
End If


H3Font = Request.Form("H3Font" )
If Len(H3Font) > 1  then
Else
H3Font= DBH3Font
End If


H3HyperlinkColor = Request.Form("H3HyperlinkColor" )
If Len(H3HyperlinkColor) > 1  then
Else
H3HyperlinkColor= H3HyperlinkColor
End If


H3MouseOverColor = Request.Form("H3MouseOverColor" )
If Len(H3MouseOverColor) > 1  then
Else
H3MouseOverColor= H3MouseOverColor
End If


H3Align = Request.Form("H3Align" )
If Len(H3Align) > 1  then
Else
H3Align= DBH3Align
End If


H3Weight = Request.Form("H3Weight" )
If Len(H3Weight) > 1  then
Else
H3Weight= DBH3Weight
End If


H3Italics = Request.Form("H3Italics" )
If Len(H3Italics) > 1  then
Else
H3Italics= DBH3Italics
End If



H4Color= Request.Form("H4Color" )
If Len(H4Color) > 1  then
Else
H4Color= DBH4Color
End If



H4size = Request.Form("H4size" )
If Len(H4size) > 1  then
Else
H4size= DBH4size
End If



H4Font = Request.Form("H4Font" )
If Len(H4Font) > 1  then
Else
H4Font= DBH4Font
End If


H4HyperlinkColor = Request.Form("H4HyperlinkColor" )
If Len(H4HyperlinkColor) > 1  then
Else
H4HyperlinkColor= H4HyperlinkColor
End If


H4MouseOverColor = Request.Form("H4MouseOverColor" )
If Len(H4MouseOverColor) > 1  then
Else
H4MouseOverColor= DBH4MouseOverColor
End If


H4Align = Request.Form("H4Align" )
If Len(H4Align) > 1  then
Else
H4Align= DBH4Align
End If


H4Weight = Request.Form("H4Weight" )
If Len(H4Weight) > 1  then
Else
H4Weight= DBH4Weight
End If


H4Italics = Request.Form("H4Italics" )
If Len(H4Italics) > 1  then
Else
H4Italics= DBH4Italics
End If


response.write("TitleSize=" & TitleSize )
if len(Titlesize) > 0 then
  else
TitleSize= 16 
end if
%> 





<style>

		H1 {font: <%=TitleSize %>pt <%=TitleFont %>; font-weight:  <%=TitleWeight %> ;  <% if TitleItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=TitleColor %>; text-align: <%=TitleAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 36 %>px; PADDING-TOP: 0px; }
		H2 {font: <%=H2Size %>pt <%=H2Font %>;  font-weight:  <%=TitleWeight %> ;  <% if H2Italics = "Yes" then %> font-style: italic;<% end if %> color: <%=H2Color %>; text-align: <%=H2Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 26 %>px; PADDING-TOP: 0px; }
		H3 {font: <%=H3Size %>pt <%=H3Font %>;  font-weight:  <%=TitleWeight %> ;  <% if H2Italics = "Yes" then %> font-style: italic;<% end if %> color: <%=H3Color %>; text-align: <%=H3Align %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize + 6 %>px; PADDING-TOP: 0px; }

		LI UL {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; color: <%=PageTextHyperlinkColor %>; text-decoration :none;}
		.Body {font: <%=PageTextFontSize%>pt <%=PageTextFont%>;  font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextColor %>; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Body {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=PageTextHyperlinkColor %>; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Body:hover {font: <%=PageTextFontSize%>pt <%=PageTextFont%>; color: <%=PageTextHyperlinkColor %>; font-weight:  <%=PageTextWeight %> ;  <% if PageTextItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=PageTextMouseOverColor %> ; text-decoration :none; text-align: <%=PageTextAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		
		
		.Menu {font: <%=MenuSize%>pt <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=MenuColor %>; text-align: center; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Menu {font: <%=MenuSize%>pt <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=MenuHyperlinkColor %>; text-align: center; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }

		A.Menu:Hover { font: <%=MenuSize%>pt <%=MenuFont%>; font-weight:  <%=MenuWeight %> ;  <% if MenuItalics = "Yes" then %> font-style: italic;<% end if %>  color: <%=MenuFontMouseOverColor %> ; text-align: <%=MenuAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		
		.Footer {font: <%=FooterTextSize%>pt <%=FooterTextFont %>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterTextColor%> ; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; LINE-HEIGHT: <%=TitleSize +2 %>px; PADDING-TOP: 0px; }
		A.Footer {font: <%=FooterTextSize%>pt <%=FooterTextFont%>; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %> color: <%=FooterHyperlinkColor %>; text-decoration :none; text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; ; PADDING-TOP: 0px; }
		
		
		A.Footer:hover {font: <%=FooterTextSize%>pt <%=FooterTextFont%>; color: <%=FooterMouseOverColor%> ; text-decoration :none; font-weight:  <%=FooterWeight %> ;  <% if FooterItalics = "Yes" then %> font-style: italic;<% end if %>  text-align: <%=FooterAlign %>; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px;  PADDING-TOP: 0px; }
		
</style>

<% response.write("Hello World") %>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"   ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Font Styles</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" height = "300" width = "960">

<a name="Top"></a>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "960" >
<tr>
  <td Class = "body">
	The fonts below apply to your entire website. As you make changes to the fonts below they will automatically be updated on this page but not on your website. When you are happy with your changes select the publish button above.<br /><br />
</td>
	</tr>
</table>
<table>
<form action= 'AdminStyleFonts.asp' method = "post" target = "_self">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "960">
	<tr>
		<td class = "body" width = "480" valign = "top"> 	 
		   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "480">

<tr>
  <td class = "body" bgcolor = "<%=PageBackgroundColor%>"  background = "<%=PageBackgroundImage%>" colspan = "2" height = "20"><H1>Heading 1</H1></td>
</tr>

<tr>
	<td class = "small" align = "right" >
		Font Face:
		<Font face="<%=TitleFont%>"></font>
		</td>
		<td>
			<select size="1" name="TitleFont" onchange="submit();">
					<option value= "<%=TitleFont%>" selected><%=TitleFont%></option>
					<option  value="Arial" ><font face = "Arial">Arial</font></option>
					<option  value="Palatino Linotype" STYLE="font-family : Palatino Linotype; font-size : 12pt">Palatino Linotype</option>
					<option  value="Tahoma" ><font face = "Tahoma">Tahoma</font></option>	
					<option  value="Century Gothic" ><font face = "Century Gothic">Century Gothic</font></option>	
					<option  value="Lucida Sans Unicode" ><font face = "Lucida Sans Unicode">Lucida Sans Unicode</font></option>	
					<option  value="Times New Roman" ><font face = "Times New Roman">Times New Roman</font></option>	
					<option  value="Verdana" ><font face = "Verdana">Verdana</font></option>
					<option  value="Copperplate Gothic Light" ><font face = "Copperplate Gothic Light">Copperplate Gothic Light</font></option>
					<option  value="Lucida Console" ><font face = "Lucida Console">Lucida Console</font></option>
					<option  value="Gill Sans" ><font face = "Gill Sans">Gill Sans</font></option>	
					<option  value="Trebuchet MS" ><font face = "Trebuchet MS">Trebuchet MS</font></option>
					<option  value="Courier New" ><font face = "Courier New">Courier New</font></option>
					<option  value="Georgia" ><font face = "Georgia">Georgia</font></option>	
					<option  value="Comic Sans MS"><div class = "comic">Comic Sans MS</div></option>	
					</select>


		</td>
	</tr>
<tr>
	<td class = "small" align = "right">
		Font Color:
	</td>
	<td>
		<select size="1" name="TitleColor" onchange="submit();" style="width:180">
		<option value= "<%=TitleColor%>" selected><%=TitleColor%></option>
		<!--#Include file="AdminColorOptionsInclude.asp"--> 	
		</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Font Size:
		</td>
		<td>
			<select size="1" name="TitleSize" onchange="submit();" style="width:180">
					<option value= "<%=TitleSize%>" selected><%=TitleSize%></option>
					<option value="9" >9</option>	
					<option value="10" >10</option>	
					<option value="11" >11</option>	
					<option value="12" >12</option>	
					<option value="13" >13</option>	
					<option value="14" >14</option>
					<option  value="15" >15</option>
					<option  value="16" >16</option>
					<option  value="17" >17</option>
					<option  value="20" >20</option>
					<option  value="24" >24</option>
					<option  value="28" >28</option>
			</select>

	
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Alignment:
		</td>
		<td>
			<select size="1" name="TitleAlign" onchange="submit();" style="width:180">
					<option value= "<%=TitleAlign%>" selected><%=TitleAlign%></option>
					<option value="Left" >left</option>	
					<option value="Right" >Right</option>
					<option  value="Center" >Center</option>
			</select>

	
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Font Weight:
		</td>
		<td>
			<select size="1" name="TitleWeight" onchange="submit();" style="width:180">
					<option value= "<%=TitleWeight%>" selected><%=TitleWeight%></option>
					<option value="Normal" >Normal</option>	
					<option value="Bold" >Bold</option>	
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Italics?:
		</td>
		<td>
			<select size="1" name="TitleItalics" onchange="submit();" style="width:180">
					<option value= "<%=TitleItalics%>" selected><%=TitleItalics%></option>
					<option value="No" >No Italics</option>	
					<option value="Yes" >Italics</option>	
			</select>
		</td>
	</tr>
<tr>
  <td class = "body" bgcolor = "<%=PageBackgroundColor%>" background = "<%=PageBackgroundImage%>" colspan = "2" height = "20"><h2>Heading 2</h2></td>
</tr>

<tr>
	<td class = "small" align = "right">
		Font Face:
		<Font face="<%=H2Font%>"></font>
		</td>
		<td>
			<select size="1" name="H2Font" style="width:180" onchange="submit();">
					<option value= "<%=H2Font%>" selected><%=H2Font%></option>
					<option  value="Arial" ><font face = "Arial">Arial</font></option>
					<option  value="Palatino Linotype" STYLE="font-family : Palatino Linotype; font-size : 12pt">Palatino Linotype</option>
					<option  value="Tahoma" ><font face = "Tahoma">Tahoma</font></option>	
					<option  value="Century Gothic" ><font face = "Century Gothic">Century Gothic</font></option>	
					<option  value="Lucida Sans Unicode" ><font face = "Lucida Sans Unicode">Lucida Sans Unicode</font></option>	
					<option  value="Times New Roman" ><font face = "Times New Roman">Times New Roman</font></option>	
					<option  value="Verdana" ><font face = "Verdana">Verdana</font></option>
					<option  value="Copperplate Gothic Light" ><font face = "Copperplate Gothic Light">Copperplate Gothic Light</font></option>
					<option  value="Lucida Console" ><font face = "Lucida Console">Lucida Console</font></option>
					<option  value="Gill Sans" ><font face = "Gill Sans">Gill Sans</font></option>	
					<option  value="Trebuchet MS" ><font face = "Trebuchet MS">Trebuchet MS</font></option>
					<option  value="Courier New" ><font face = "Courier New">Courier New</font></option>
					<option  value="Georgia" ><font face = "Georgia">Georgia</font></option>	
					<option  value="Comic Sans MS"><div class = "comic">Comic Sans MS</div></option>	
					</select>


		</td>
	</tr>
<tr>
	<td class = "small" align = "right">
		Font Color:
	</td>
	<td>
		<select size="1" name="H2Color" style="width:180" onchange="submit();">
		<option value= "<%=H2Color%>" selected><%=H2Color%></option>
		<!--#Include file="AdminColorOptionsInclude.asp"--> 	
		</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Font Size:
		</td>
		<td>
			<select size="1" name="H2Size" style="width:180" onchange="submit();">
					<option value= "<%=H2Size%>" selected><%=H2Size%></option>
					<option value="10" >10</option>	
					<option value="11" >11</option>	
					<option value="12" >12</option>	
					<option value="13" >13</option>	
					<option value="14" >14</option>
					<option  value="15" >15</option>
					<option  value="16" >16</option>
					<option  value="17" >17</option>
			</select>

	
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Alignment:
		</td>
		<td>
			<select size="1" name="H2Align" style="width:180" onchange="submit();">
					<option value= "<%=H2Align%>" selected><%=H2Align%></option>
					<option value="Left" >left</option>	
					<option value="Right" >Right</option>
					<option  value="Center" >Center</option>
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Font Weight:
		</td>
		<td>
			<select size="1" name="H2Weight" style="width:180" onchange="submit();">
					<option value= "<%=H2Weight%>" selected><%=H2Weight%></option>
					<option value="Normal" >Normal</option>	
					<option value="Bold" >Bold</option>	
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Italics?:
		</td>
		<td>
			<select size="1" name="H2Italics" style="width:180" onchange="submit();">
					<option value= "<%=H2Italics%>" selected><%=H2Italics%></option>
					<option value="No" >No Italics</option>	
					<option value="Yes" >Italics</option>	
			</select>
		</td>
	</tr>

	<tr>
  <td class = "body" bgcolor = "<%=PageBackgroundColor%>"  background = "<%=PageBackgroundImage%>" colspan = "2" height = "20"><h3>Heading 3</h3></td>
</tr>



<tr>
	<td class = "small" align = "right">
		Font Face:
		<Font face="<%=H3Font%>"></font>
		</td>
		<td>
			<select size="1" name="H3Font" style="width:180" onchange="submit();">
					<option value= "<%=H3Font%>" selected><%=H3Font%></option>
					<option  value="Arial" ><font face = "Arial">Arial</font></option>
					<option  value="Palatino Linotype" STYLE="font-family : Palatino Linotype; font-size : 12pt">Palatino Linotype</option>
					<option  value="Tahoma" ><font face = "Tahoma">Tahoma</font></option>	
					<option  value="Century Gothic" ><font face = "Century Gothic">Century Gothic</font></option>	
					<option  value="Lucida Sans Unicode" ><font face = "Lucida Sans Unicode">Lucida Sans Unicode</font></option>	
					<option  value="Times New Roman" ><font face = "Times New Roman">Times New Roman</font></option>	
					<option  value="Verdana" ><font face = "Verdana">Verdana</font></option>
					<option  value="Copperplate Gothic Light" ><font face = "Copperplate Gothic Light">Copperplate Gothic Light</font></option>
					<option  value="Lucida Console" ><font face = "Lucida Console">Lucida Console</font></option>
					<option  value="Gill Sans" ><font face = "Gill Sans">Gill Sans</font></option>	
					<option  value="Trebuchet MS" ><font face = "Trebuchet MS">Trebuchet MS</font></option>
					<option  value="Courier New" ><font face = "Courier New">Courier New</font></option>
					<option  value="Georgia" ><font face = "Georgia">Georgia</font></option>	
					<option  value="Comic Sans MS"><div class = "comic">Comic Sans MS</div></option>	
					</select>


		</td>
	</tr>
<tr>
	<td class = "small" align = "right" >
		Font Color:
	</td>
	<td>
		<select size="1" name="H3Color" style="width:180" onchange="submit();">
		<option value= "<%=H3Color%>" selected><%=H3Color%></option>
		<!--#Include file="AdminColorOptionsInclude.asp"--> 	
		</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Font Size:
		</td>
		<td>
			<select size="1" name="H3Size" style="width:180" onchange="submit();">
					<option value= "<%=H3Size%>" selected><%=H3Size%></option>
					<option value="10" >10</option>	
					<option value="11" >11</option>	
					<option value="12" >12</option>	
					<option value="13" >13</option>	
					<option value="14" >14</option>
					<option  value="15" >15</option>
					<option  value="16" >16</option>
					<option  value="17" >17</option>
			</select>

	
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Alignment:
		</td>
		<td>
			<select size="1" name="H3Align" style="width:180" onchange="submit();">
					<option value= "<%=H3Align%>" selected><%=H3Align%></option>
					<option value="Left" >left</option>	
					<option value="Right" >Right</option>
					<option  value="Center" >Center</option>
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Font Weight:
		</td>
		<td>
			<select size="1" name="H3Weight" style="width:180" onchange="submit();">
					<option value= "<%=H3Weight%>" selected><%=H3Weight%></option>
					<option value="Normal" >Normal</option>	
					<option value="Bold" >Bold</option>	
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right" >
			Italics?:
		</td>
		<td>
			<select size="1" name="H3Italics" style="width:180" onchange="submit();">
					<option value= "<%=H3Italics%>" selected><%=H3Italics%></option>
					<option value="No" >No Italics</option>	
					<option value="Yes" >Italics</option>	
			</select>
		</td>
	</tr>
</table>
</td>	
<td bgcolor = "black"><img src = "images/px.gif" width = "1" height = "1">
<td valign = "top" width = "480">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "460" align = "center">
  <td class = "menu" bgcolor = "<%=MenuBackgroundColor%>" background = "<%=MenuBackgroundImage%>"colspan = "2" height = "20"><font class = "Menu">Menu</font>  <a href = "#" class = "Menu">Menu Link</a></td>
</tr>

<tr>
	<td class = "small" width = "195" align = "right">
		Font Face:
		<Font face="<%=MenuFont%>"></font>
		</td>
		<td>
			<select size="1" name="MenuFont" onchange="submit();" style="width:180">
					<option value= "<%=MenuFont%>" selected><Font face="<%=MenuFont%>"><%=MenuFont%></font></option>
					<option  value="Arial" ><font face = "Arial">Arial</font></option>
					<option  value="Palatino Linotype" STYLE="font-family : Palatino Linotype; font-size : 12pt">Palatino Linotype</option>
					<option  value="Tahoma" ><font face = "Tahoma">Tahoma</font></option>	
					<option  value="Century Gothic" ><font face = "Century Gothic">Century Gothic</font></option>	
					<option  value="Lucida Sans Unicode" ><font face = "Lucida Sans Unicode">Lucida Sans Unicode</font></option>	
					<option  value="Times New Roman" ><font face = "Times New Roman">Times New Roman</font></option>	
					<option  value="Verdana" ><font face = "Verdana">Verdana</font></option>
					<option  value="Copperplate Gothic Light" ><font face = "Copperplate Gothic Light">Copperplate Gothic Light</font></option>
					<option  value="Lucida Console" ><font face = "Lucida Console">Lucida Console</font></option>
					<option  value="Gill Sans" ><font face = "Gill Sans">Gill Sans</font></option>	
					<option  value="Trebuchet MS" ><font face = "Trebuchet MS">Trebuchet MS</font></option>
					<option  value="Courier New" ><font face = "Courier New">Courier New</font></option>
					<option  value="Georgia" ><font face = "Georgia">Georgia</font></option>	
					<option  value="Comic Sans MS"><div class = "comic">Comic Sans MS</div></option>	
					</select>


		</td>
	</tr>
	<tr>
	<td class = "small" align = "right">
		Font Color:
		</td>
		<td>
			<select size="1" name="MenuColor" onchange="submit();" style="width:180">
					<option value= "<%=MenuFontColor%>" selected><%=MenuColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Font Size:
		</td>
		<td>
			<select size="1" name="MenuSize" onchange="submit();" style="width:180">
					<option value= "<%=MenuSize%>" selected><%=MenuSize%></option>
					<option value="9" >9</option>	
					<option value="10" >10</option>	
					<option value="11" >11</option>	
					<option value="12" >12</option>	
					<option value="13" >13</option>	
					<option value="14" >14</option>
					<option  value="15" >15</option>
					<option  value="16" >16</option>
					<option  value="17" >17</option>
			</select>

	
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Alignment:
		</td>
		<td>
			<select size="1" name="MenuAlign" onchange="submit();" style="width:180">
					<option value= "<%=MenuAlign%>" selected><%=MenuAlign%></option>
					<option value="Left" >left</option>	
					<option value="Right" >Right</option>
					<option  value="Center" >Center</option>
			</select>

	
		</td>
	</tr>

	<tr>
		<td class = "small" align = "right">
			Font Weight:
		</td>
		<td>
			<select size="1" name="MenuWeight" onchange="submit();" style="width:180">
					<option value= "<%=MenuWeight%>" selected><%=MenuWeight%></option>
					<option value="Normal" >Normal</option>	
					<option value="Bold" >Bold</option>	
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Italics?:
		</td>
		<td>
			<select size="1" name="MenuItalics" onchange="submit();" style="width:180">
					<option value= "<%=MenuItalics%>" selected><%=MenuItalics%></option>
					<option value="No" >No Italics</option>	
					<option value="Yes" >Italics</option>	
			</select>
		</td>
	</tr>

<tr>
	<td class = "small" align = "right">
			Link Color:
		</td>
		<td>
			<select size="1" name="MenuHyperlinkColor" style="width:180" onchange="submit();">
					<option value= "<%=MenuHyperlinkColor%>" selected><%=MenuHyperlinkColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
	</tr>
	<tr>
	<td class = "small" align = "right">
			Link Mouseover Color:
		</td>
		<td>
			<select size="1" name="MenuFontMouseOverColor"style=" width:180" onchange="submit();">
					<option value= "<%=MenuFontMouseOverColor%>" selected><%=MenuFontMouseOverColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
</tr>














<tr>
  <td class = "Body" bgcolor = "<%=PageBackgroundColor%>" background = "<%=PageBackgroundImage%>" colspan = "2" height = "20">Body Text <a href = "#" class = "Body">Body Text Link</a> </td>
</tr>
<tr>

<tr>
	<td class = "small" align = "right">
		Page Text Font:
		</td>
		<td>
			<select size="1" name="PageTextFont" style="width:180" onchange="submit();">
					<option value= "<%=PageTextFont%>" selected><Font face="<%=PageTextFont%>"><%=PageTextFont%></font></option>
					<option  value="Arial" ><font face = "Arial">Arial</font></option>
					<option  value="Palatino Linotype" STYLE="font-family : Palatino Linotype; font-size : 12pt">Palatino Linotype</option>
					<option  value="Tahoma" ><font face = "Tahoma">Tahoma</font></option>	
					<option  value="Century Gothic" ><font face = "Century Gothic">Century Gothic</font></option>	
					<option  value="Lucida Sans Unicode" ><font face = "Lucida Sans Unicode">Lucida Sans Unicode</font></option>	
					<option  value="Times New Roman" ><font face = "Times New Roman">Times New Roman</font></option>	
					<option  value="Verdana" ><font face = "Verdana">Verdana</font></option>
					<option  value="Copperplate Gothic Light" ><font face = "Copperplate Gothic Light">Copperplate Gothic Light</font></option>
					<option  value="Lucida Console" ><font face = "Lucida Console">Lucida Console</font></option>
					<option  value="Gill Sans" ><font face = "Gill Sans">Gill Sans</font></option>	
					<option  value="Trebuchet MS" ><font face = "Trebuchet MS">Trebuchet MS</font></option>
					<option  value="Courier New" ><font face = "Courier New">Courier New</font></option>
					<option  value="Georgia" ><font face = "Georgia">Georgia</font></option>	
					<option  value="Comic Sans MS"><div class = "comic">Comic Sans MS</div></option>	
					</select>


		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Color:
		</td>
		<td>
			<select size="1" name="PageTextColor" style="width:180" onchange="submit();">
					<option value= "<%=PageTextColor%>" selected><%=PageTextColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
	</tr>
	
		<tr>
		<td class = "small" align = "right" >
			Page Text Size:
		</td>
		<td>
			<select size="1" name="PageTextFontSize"  style="width:180" onchange="submit();" >
					<option value= "<%=PageTextFontSize%>" selected><%=PageTextFontSize%></option>
					<option value="10" >10</option>	
					<option value="11" >11</option>
					<option  value="13" >13</option>
			</select>

	
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Alignment:
		</td>
		<td>
			<select size="1" name="PageTextAlign" style="width:180" onchange="submit();">
					<option value= "<%=PageTextAlign%>" selected><%=PageTextAlign%></option>
					<option value="Left" >left</option>	
					<option value="Right" >Right</option>
					<option  value="Center" >Center</option>
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right" >
			Font Weight:
		</td>
		<td>
			<select size="1" name="PageTextWeight" style="width:180" onchange="submit();">
					<option value= "<%=PageTextWeight%>" selected><%=PageTextWeight%></option>
					<option value="Normal" >Normal</option>	
					<option value="Bold" >Bold</option>	
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Italics?:
		</td>
		<td>
			<select size="1" name="PageTextItalics" style="width:180" onchange="submit();">
					<option value= "<%=PageTextItalics%>" selected><%=PageTextItalics%></option>
					<option value="No" >No Italics</option>	
					<option value="Yes" >Italics</option>	
			</select>
		</td>
	</tr>
	<tr>
	<td class = "small" align = "right">
			Link Color:
		</td>
		<td>
			<select size="1" name="PageTextHyperlinkColor" style="width:180" onchange="submit();">
					<option value= "<%=PageTextHyperlinkColor%>" selected><%=PageTextHyperlinkColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	<tr>
	<td class = "small" align = "right">
			Link Mouseover Color:
		</td>
		<td>
			<select size="1" name="PageTextMouseOverColor"style=" width:180" onchange="submit();">
					<option value= "<%=PageTextMouseOverColor%>" selected><%=PageTextMouseOverColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
</tr>
<tr>
  <td class = "Footer" bgcolor = "<%=FooterBackgroundColor%>"  background = "<%=FooterBackgroundImage%>"  colspan = "2" height = "20">Footer Text <a href = "#" class = "Footer">Footer Text Link</a> </td>
</tr>

<tr>
	<td class = "small" align = "right">
		Footer Font:
		</td>
		<td>
			<select size="1" name="FooterTextFont" style="width:180" onchange="submit();">
					<option value= "<%=FooterTextFont%>" selected><Font face="<%=FooterTextFont%>"><%=FooterTextFont%></font></option>
					<option  value="Arial" ><font face = "Arial">Arial</font></option>
					<option  value="Palatino Linotype" STYLE="font-family : Palatino Linotype; font-size : 12pt">Palatino Linotype</option>
					<option  value="Tahoma" ><font face = "Tahoma">Tahoma</font></option>	
					<option  value="Century Gothic" ><font face = "Century Gothic">Century Gothic</font></option>	
					<option  value="Lucida Sans Unicode" ><font face = "Lucida Sans Unicode">Lucida Sans Unicode</font></option>	
					<option  value="Times New Roman" ><font face = "Times New Roman">Times New Roman</font></option>	
					<option  value="Verdana" ><font face = "Verdana">Verdana</font></option>
					<option  value="Copperplate Gothic Light" ><font face = "Copperplate Gothic Light">Copperplate Gothic Light</font></option>
					<option  value="Lucida Console" ><font face = "Lucida Console">Lucida Console</font></option>
					<option  value="Gill Sans" ><font face = "Gill Sans">Gill Sans</font></option>	
					<option  value="Trebuchet MS" ><font face = "Trebuchet MS">Trebuchet MS</font></option>
					<option  value="Courier New" ><font face = "Courier New">Courier New</font></option>
					<option  value="Georgia" ><font face = "Georgia">Georgia</font></option>	
					<option  value="Comic Sans MS"><div class = "comic">Comic Sans MS</div></option>	
					</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right" >
			Font Color:
		</td>
		<td>
			<select size="1" name="FooterTextColor" style="width:180" onchange="submit();">
					<option value= "<%=FooterTextColor%>" selected><%=FooterTextColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	<tr>
	<td class = "small" align = "right">
			Link Color:
		</td>
		<td>
			<select size="1" name="FooterHyperlinkColor" style="width:180" onchange="submit();" >
					<option value= "<%=FooterHyperlinkColor%>" selected><%=FooterHyperlinkColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	<tr>
	<td class = "small" align = "right">
			Link Mouseover Color:
		</td>
		<td>
			<select size="1" name="FooterMouseOverColor" style="width:180" onchange="submit();">
					<option value= "<%=FooterMouseOverColor%>" selected><%=FooterMouseOverColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
</tr>
		<tr>
		<td class = "small" align = "right">
			Text Size:
		</td>
		<td>
<select size="1" name="FooterTextSize" style="width:180" onchange="submit();" >
<option value= "<%=FooterTextSize%>" selected><%=FooterTextSize%></option>
<option  value="11" >11</option>
<option  value="12" >12</option>
<option  value="13" >13</option>
<option  value="14" >14</option>
<option  value="15" >15</option>
<option  value="16" >16</option>
</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right">
			Alignment:
		</td>
		<td>
			<select size="1" name="FooterAlign" style="width:180" onchange="submit();">
					<option value= "<%=FooterAlign%>" selected><%=FooterAlign%></option>
					<option value="Left" >left</option>	
					<option value="Right" >Right</option>
					<option  value="Center" >Center</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class = "small" align = "right" >
			Font Weight:
		</td>
		<td>
			<select size="1" name="FooterWeight" style="width:180" onchange="submit();">
					<option value= "<%=FooterWeight%>" selected><%=FooterWeight%></option>
					<option value="Normal" >Normal</option>	
					<option value="Bold" >Bold</option>	
			</select>
		</td>
	</tr>
<tr>
		<td class = "small" align = "right">
			Italics?:
		</td>
		<td>
			<select size="1" name="FooterItalics" style="width:180" onchange="submit();">
					<option value= "<%=FooterItalics%>" selected><%=FooterItalics%></option>
					<option value="No" >No Italics</option>	
					<option value="Yes" >Italics</option>	
			</select>
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
</form>
		</td>
	</tr>
</table>

</td>
	</tr>
</table>
<%	Query =  " UPDATE SiteDesignTemp Set TitleColor = '" & TitleColor  & "' ,"
	Query =  Query & " TitleFont = '" & TitleFont  & "' ,"
	Query =  Query & " TitleSize = '" & TitleSize & "' ,"
	Query =  Query & " TitleAlign = '" & TitleAlign & "' ,"
	Query =  Query & " TitleWeight = '" & TitleWeight & "' ,"
	Query =  Query & " TitleItalics = '" & TitleItalics & "' ,"

	Query =  Query & "  MenuColor= '" & MenuColor & "' ,"
	Query =  Query & " MenuFontMouseOverColor = '" & MenuFontMouseOverColor & "' ,"
	Query =  Query & "  MenuSize= '" & MenuSize & "' ,"
	Query =  Query & "  MenuFont= '" & MenuFont & "' ,"
	Query =  Query & "  MenuAlign= '" & MenuAlign & "' ,"
	Query =  Query & " MenuWeight = '" & MenuWeight & "' ,"
	Query =  Query & " MenuItalics = '" & MenuItalics & "' ,"
	Query =  Query & " MenuHyperlinkColor = '" & MenuHyperlinkColor & "' ,"

	Query =  Query & " PageTextColor = '" & PageTextColor & "' ,"
	Query =  Query & " PageTextFont = '" & PageTextFont & "' ,"
	Query =  Query & " PageTextFontSize = '" & PageTextFontSize & "' ,"
	Query =  Query & " PageTextHyperlinkColor = '" & PageTextHyperlinkColor & "' ,"
	Query =  Query & " PageTextMouseOverColor = '" & PageTextMouseOverColor & "' ,"
	Query =  Query & " PageTextAlign = '" & PageTextAlign & "' ,"
	Query =  Query & " PageTextWeight = '" & PageTextWeight & "' ,"
	Query =  Query & " PageTextItalics = '" & PageTextItalics & "' ,"

	Query =  Query & " FooterColor = '" & FooterColor & "' ,"
	Query =  Query & " FooterTextColor = '" & FooterTextColor & "' ,"
	Query =  Query & " FooterTextFont = '" & FooterTextFont & "' ,"
	Query =  Query & " FooterHyperlinkColor = '" & FooterHyperlinkColor & "' ,"
	Query =  Query & " FooterMouseOverColor = '" & FooterMouseOverColor & "' ,"
	Query =  Query & " FooterTextSize = '" & FooterTextSize & "' ,"
	Query =  Query & " FooterAlign = '" & FooterAlign & "' ,"
	Query =  Query & " FooterWeight = '" & FooterWeight & "' ,"
	Query =  Query & " FooterItalics = '" & FooterItalics & "' ,"


	Query =  Query & " H2Color = '" & H2Color & "' ,"
	Query =  Query & " H2Font = '" & H2Font & "' ,"
	Query =  Query & " H2HyperlinkColor = '" & H2HyperlinkColor & "' ,"
	Query =  Query & " H2MouseOverColor = '" & H2MouseOverColor & "' ,"
	Query =  Query & " H2Size = '" & H2Size & "' ,"
	Query =  Query & " H2Align = '" & H2Align & "' ,"
	Query =  Query & " H2Weight = '" & H2Weight & "' ,"
	Query =  Query & " H2Italics = '" & H2Italics & "' ,"

	Query =  Query & " H3Color = '" & H3Color & "' ,"
	Query =  Query & " H3Font = '" & H3Font & "' ,"
	Query =  Query & " H3HyperlinkColor = '" & H3HyperlinkColor & "' ,"
	Query =  Query & " H3MouseOverColor = '" & H3MouseOverColor & "' ,"
	Query =  Query & " H3Size = '" & H3Size & "' ,"
	Query =  Query & " H3Align = '" & H3Align & "' ,"
	Query =  Query & " H3Weight = '" & H3Weight & "' ,"
	Query =  Query & " H3Italics = '" & H3Italics & "' ,"


	Query =  Query & " H4Color = '" & H4Color & "' ,"
	Query =  Query & " H4Font = '" & H4Font & "' ,"
	Query =  Query & " H4HyperlinkColor = '" & H4HyperlinkColor & "' ,"
	Query =  Query & " H4MouseOverColor = '" & H4MouseOverColor & "' ,"
	Query =  Query & " H4Size = '" & H4Size & "' ,"
	Query =  Query & " H4Align = '" & H4Align & "' ,"		
	Query =  Query & " H4Weight = '" & H4Weight & "' ,"
	Query =  Query & " H4Italics = '" & H4Italics & "' "

   Query =  Query & " where PeopleID = " & PeopleID

response.write(Query)	

Conn.Execute(Query) 
end if
%>
</body>
</html>
