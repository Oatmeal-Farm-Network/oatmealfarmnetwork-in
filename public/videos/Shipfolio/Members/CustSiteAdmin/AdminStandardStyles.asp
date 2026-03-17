<!DOCTYPE HTML >
<html>
<head>
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminglobalvariablesFrame.asp"--> 
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
 <% Page = "Editwebsite" %>
<link rel="stylesheet" type="text/css" href="/administration/AdminFramestyle.css">
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<table width = "980" height = "450" bgcolor = "white" border = "0" cellspacing = "0" cellpadding = "0"><tr><td>
<% 
OwnerPeopleID = 667
 sql = "select * from SiteDesigntemp where PeopleID=" & OwnerPeopleID
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
Header = rs("Header")
logo = rs("Logo")
sql = "select * from SiteDesigntemp where PeopleID=" & OwnerPeopleID
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
Header = rs("Header")
logo = rs("Logo")
DBPicturesBorder = rs("PicturesBorder")
DBPicturesBorderSize = rs("PicturesBorderSize")
DBPicturesBorderColor = rs("PicturesBorderColor")
DBPicturesShadow = rs("PicturesShadow")
DBFooterShadow = rs("FooterShadow")
DBFooterRoundedCorners = rs("FooterRoundedCorners")
DBPagewidth = rs("Pagewidth")
DBPageAlign = rs("PageAlign")
DBLayoutStyle = rs("LayoutStyle")
DBScreenBackgroundColor = rs("ScreenBackgroundColor")
DBPageBorder = rs("PageBorder")
DBPageBorderColor = rs("PageBorderColor")
DBMenuBackgroundColor = rs("MenuBackgroundColor")
DBPageBackgroundColor = rs("PageBackgroundColor")
DBFooterColor = rs("FooterColor")
DBFooterShadow = rs("FooterShadow")
DBMenuDropdownColor = rs("MenuDropdownColor")
DBMenuShadow  = rs("MenuShadow")
DBMenuRoundedCorners = rs("MenuRoundedCorners")
DBMenuDropdownColorMouseover = rs("MenuDropdownColorMouseover")
	
Dim str1
Dim str2
str1 = DBMenuBackgroundColor
str2 = "'"
If InStr(str1,str2) > 0 Then
	DBMenuBackgroundColor= Replace(str1,  str2, "''")
End If  


Pagewidth=Request.Form("Pagewidth" ) 
If Len(Pagewidth) > 1  then
Else
	Pagewidth = DBPagewidth
End If

PageAlign=Request.Form("PageAlign" )
If Len(PageAlign) > 1  then
Else
PageAlign = DBPageAlign
End If


LayoutStyle=Request.Form("LayoutStyle" ) 

If Len(LayoutStyle) > 1  then
Else
	LayoutStyle = DBLayoutStyle
End If

ScreenBackgroundColor=Request.Form("ScreenBackgroundColor" ) 
If Len(ScreenBackgroundColor) > 1  then
Else
ScreenBackgroundColor = DBScreenBackgroundColor
End If


PageBorder=Request.Form("PageBorder" ) 
If Len(PageBorder) > 0  then
Else
PageBorder = DBPageBorder
End If


PageBorderColor=Request.Form("PageBorderColor" ) 
If Len(PageBorderColor) > 1  then
Else
PageBorderColor = DBPageBorderColor
End If

MenuBackgroundColor=Request.Form("MenuBackgroundColor" ) 
If Len(MenuBackgroundColor) > 1  then
Else
MenuBackgroundColor = DBMenuBackgroundColor
End If

PageBackgroundColor=Request.Form("PageBackgroundColor" ) 
If Len(PageBackgroundColor) > 1  then
Else
PageBackgroundColor = DBPageBackgroundColor
End If

MenuDropdownColorMouseover=Request.Form("MenuDropdownColorMouseover" ) 
If Len(MenuDropdownColorMouseover) > 1  then
Else
MenuDropdownColorMouseover = DBMenuDropdownColorMouseover
End If


MenuShadow=Request.Form("MenuShadow" ) 
If Len(MenuShadow) > 1  then
Else
MenuShadow = DBMenuShadow
End If

MenuRoundedCorners=Request.Form("MenuRoundedCorners" ) 
If Len(MenuRoundedCorners) > 1  then
Else
MenuRoundedCorners= DBMenuRoundedCorners
End If


FooterColor=Request.Form("FooterColor" ) 
If Len(FooterColor) > 1  then
Else
FooterColor = DBFooterColor
End If


FooterShadow=Request.Form("FooterShadow" ) 
If Len(FooterShadow) > 1  then
Else
FooterShadow = DBFooterShadow
End If

FooterRoundedCorners=Request.Form("FooterRoundedCorners" ) 
If Len(FooterRoundedCorners) > 1  then
Else
FooterRoundedCorners= DBFooterRoundedCorners
End If




PicturesBorder=Request.Form("PicturesBorder" ) 

If Len(PicturesBorder) > 1  then
Else
PicturesBorder= DBPicturesBorder
End If

PicturesBorderSize=Request.Form("PicturesBorderSize" ) 

If Len(PicturesBorderSize) > 0  then
Else
PicturesBorderSize= DBPicturesBorderSize
End If


PicturesBorderColor=Request.Form("PicturesBorderColor" ) 
If Len(PicturesBorderColor) > 1  then
Else
PicturesBorderColor= DBPicturesBorderColor
End If

PicturesShadow=Request.Form("PicturesShadow" ) 
If Len(PicturesShadow) > 1  then
Else
PicturesShadow= DBPicturesShadow
End If


FooterShadow=Request.Form("FooterShadow" ) 
If Len(FooterShadow) > 1  then
Else
FooterShadow = DBFooterShadow
End If

FooterRoundedCorners=Request.Form("FooterRoundedCorners" ) 
If Len(FooterRoundedCorners) > 1  then
Else
FooterRoundedCorners = DBFooterRoundedCorners
End If

MenuDropdownColor=Request.Form("MenuDropdownColor" ) 
If Len(MenuDropdownColor) > 1  then
Else
MenuDropdownColor = DBMenuDropdownColor
End If


if len(MenuDropdownColor) < 1 then
  MenuDropdownColor = "Black"
end if


if len(MenuShadow) < 1 then
  MenuShadow = "Yes"
end if

if len(MenuRoundedCorners) < 1 then
  MenuRoundedCorners = "Yes"
end if


if len(FooterShadow) < 1 then
  FooterShadow = "Yes"
end if

if len(FooterRoundedCorners) < 1 then
  FooterRoundedCorners = "Yes"
end if


if len(PicturesBorder) < 1 then
  PicturesBorder = "Yes"
end if

if len(PicturesShadow) < 1 then
  PicturesShadow= "Yes"
end if

if len(PicturesBorderSize) < 1 then
  PicturesBorderSize= "0"
end if

if len(PageAlign) < 1 then
  PageAlign= "center"
end if


if len(PageBorderColor) < 1 then
  PageBorderColor= "Black"
end if
 
 if len(MenuDropdownColorMouseover) < 1 then
  MenuDropdownColorMouseover= "Grey"
end if

 

Query =  " UPDATE SiteDesigntemp Set PageWidth = " & PageWidth & ","
Query =  Query & " LayoutStyle = '" & LayoutStyle & "', "
Query =  Query & " ScreenBackgroundColor = '" & ScreenBackgroundColor & "' ,"
Query =  Query & "  PageBorder = '" & PageBorder & "' ,"
Query =  Query & " PageAlign = '" & PageAlign & "' ,"
Query =  Query & "  PageBorderColor = '" & PageBorderColor & "' ,"
Query =  Query & " MenuBackgroundColor = '" & MenuBackgroundColor & "' ,"
Query =  Query & " MenuDropdownColor = '" & MenuDropdownColor & "' ,"
Query =  Query & " MenuShadow = " & MenuShadow & " ,"
Query =  Query & " MenuRoundedCorners = " & MenuRoundedCorners & " ,"
Query =  Query & " MenuDropdownColorMouseover = '" & MenuDropdownColorMouseover & "' ,"

Query =  Query & " PicturesBorder = " & PicturesBorder & " ,"
Query =  Query & " PicturesBorderSize = '" & PicturesBorderSize & "' ,"
Query =  Query & " PicturesBorderColor = '" & PicturesBorderColor & "' ,"
Query =  Query & " PicturesShadow = " & PicturesShadow & " ,"
Query =  Query & " PageBackgroundColor = '" & PageBackgroundColor & "' ,"
Query =  Query & " FooterShadow = " & FooterShadow & " ,"
Query =  Query & " FooterRoundedCorners= " & FooterRoundedCorners & " ,"
Query =  Query & " FooterColor = '" & FooterColor & "' "
Query =  Query & " where PeopleID = " & OwnerPeopleID  
'response.write(Query)	

	Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 


Query =  " UPDATE SiteDesign Set PageWidth = " & PageWidth & ","
Query =  Query & " LayoutStyle = '" & LayoutStyle & "', "
Query =  Query & " ScreenBackgroundColor = '" & ScreenBackgroundColor & "' ,"
Query =  Query & "  PageBorder = '" & PageBorder & "' ,"
Query =  Query & " PageAlign = '" & PageAlign & "' ,"
Query =  Query & "  PageBorderColor = '" & PageBorderColor & "' ,"
Query =  Query & " MenuBackgroundColor = '" & MenuBackgroundColor & "' ,"
Query =  Query & " MenuDropdownColor = '" & MenuDropdownColor & "' ,"
Query =  Query & " MenuShadow = " & MenuShadow & " ,"
Query =  Query & " MenuRoundedCorners = " & MenuRoundedCorners & " ,"
Query =  Query & " MenuDropdownColorMouseover = '" & MenuDropdownColorMouseover & "' ,"

Query =  Query & " PicturesBorder = " & PicturesBorder & " ,"
Query =  Query & " PicturesBorderSize = '" & PicturesBorderSize & "' ,"
Query =  Query & " PicturesBorderColor = '" & PicturesBorderColor & "' ,"
Query =  Query & " PicturesShadow = " & PicturesShadow & " ,"
Query =  Query & " PageBackgroundColor = '" & PageBackgroundColor & "' ,"
Query =  Query & " FooterShadow = " & FooterShadow & " ,"
Query =  Query & " FooterRoundedCorners= " & FooterRoundedCorners & " ,"
Query =  Query & " FooterColor = '" & FooterColor & "' "
Query =  Query & " where PeopleID = " & OwnerPeopleID  
'response.write(Query)	

DataConnection.Execute(Query) 
set DataConnection = nothing
%>

<a name="Top"></a>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
 <tr><td  align = "left" width = "480" valign = "top">
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
     <tr><td class = "roundedtop" align = "left" valign = "top">
		<H2><div align = "left">Website Colors and Layout</div></H2
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460" valign = "top">
        
        <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "460">
				<tr>
					<td class ="body" colspan = "2" >
						The settings below control the overall layout of your 
						website. As you make changes they will automatically be applied to the preview to the right; however, they will not effect your website until you select the "Publish!" button above.<br><br>
					</td>
			 </tr>
			 <form action= 'AdminStandardStyles.asp' method = "post">	 
<tr>
		<td class = "body" align = "right">
				<b>Page Layout</b>
				
		</td>
		<td align = "left">
			
		</td>
	</tr>

<tr>
		<td class = "body" align = "right">
		<a class="tooltip" href="#"><b>Layout Style:</b><span class="custom info"><em>Layout Style</em>We offer different layout styles (Landscape, Classic Portrait, and Modern Portrait). Please see Layout Styles illustration below.</span></a>
	
		</td>
		<td align = "left">
			<select size="1" name="LayoutStyle" onchange="submit();" style="width:180">
					<option value= "<%=LayoutStyle%>" selected><%=LayoutStyle%></option>
						<option value= "Portrait1" >Portrait 1</option>
						<option value= "Portrait2" >Portrait 2</option>
						<option value= "Landscape" >Landscape</option>
					</select>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
		<a class="tooltip" href="#"><b>Page Alignment:</b><span class="custom info"><em>Page Alignment</em>Do you want your page to be on the left side of the screen or in the center? You can control that with the page align selection.</span></a>
		</td>
		<td align = "left">
			<select size="1" name="PageAlign" onchange="submit();" style="width:180">
					<option value= "<%=PageAlign%>" selected><%=PageAlign%></option>
					<option value="Left" >Left</option>	
					<option  value="Center" >Center</option>
			</select>
		</td>
	</tr>

	
	<tr>
		<td class = "body" align = "right">
				<a class="tooltip" href="#"><b>Screen Background Color:</b><span class="custom info"><em>Screen Background Color</em>This color is seen on the sides of your pages, unless you have uploaded a Screen Background Image. To upload a Screen Background Image goes to the bottom of this page.</span></a>
	
		</td>
		<td align = "left">
			<select size="1" name="ScreenBackgroundColor" onchange="submit()" style="width:180">
					<option value= "<%=ScreenBackgroundColor%>" selected><%=ScreenBackgroundColor%></option>
					<!--#Include file="AdminColorOptionsInclude.asp"--> 		
	
					</select>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			<a class="tooltip" href="#"><b>Page Border Size:</b><span class="custom info"><em>Page Border Size</em>Would you like a border around your web pages? If not then select 0 pixels, otherwise select the width of your border - 1, 2, or 3 pixels.</span></a>
	</td>
		<td align = "left">
			<select size="1" name="PageBorder" onchange="submit();" style="width:180">
					<option value= "<%=PageBorder%>" selected><%=PageBorder%> pixel(s)</option>
						<option value= "0" >0 - No Border</option>
						<option value= "1" >1 pixel</option>
						<option value= "2" >2 pixels</option>
						<option value= "3" >3 pixels</option>
					</select>
		</td>
	</tr>
	<% if len(PageBorder) > 0 then %>
<tr>
		<td class = "body" align = "right" >
		<a class="tooltip" href="#"><b>Page Border Color:</b><span class="custom info"><em>Page Border Color</em>If you picked a border, then pick a color.</span></a>
		
		</td>
		<td align = "left">
			<select size="1" name="PageBorderColor" onchange="submit();" style="width:180">
					<option value= "<%=PageBorderColor%>" selected><%=PageBorderColor%></option>
					<!--#Include file="AdminColorOptionsInclude.asp"--> 		
					</select>
		</td>
	</tr>
<% end if %>
<tr>
		<td class = "body" align = "right">
				<a class="tooltip" href="#"><b>Page Background Color:</b><span class="custom info"><em>Page Background Color</em>This color is seen in the body of your pages, unless you have uploaded a Page Background Image. To upload a Page Background Image go to the bottom of this page.</span></a>
				
		</td>
		<td align = "left">
			<select size="1" name="PageBackgroundColor" onchange="submit();" style="width:180">
					<option value= "<%=PageBackgroundColor%>" selected><%=PageBackgroundColor%></option>
					<!--#Include file="AdminColorOptionsInclude.asp"--> 		
					</select>
		</td>
	</tr>

<tr>
		<td class = "body" align = "right">
				<b>Menu</b>
				
		</td>
		<td align = "left">
			
		</td>
	</tr>

<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Menu Background Color:</b><span class="custom info"><em>Menu Background Color</em>This color is seen behind your menu links, unless you have uploaded a Menu Background Image. To upload a Menu Background Image go to the bottom of this page.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="MenuBackgroundColor" onchange="submit();" style="width:180">
					<option value= "<%=MenuBackgroundColor%>" selected><%=MenuBackgroundColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
<% if LayoutStyle = "Landscape" then %>
<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Menu Dropdown Color:</b><span class="custom info"><em>Menu Dropdown Color</em>If you are using a landscape layout style then your menu uses dropdown menus. You can set what color that you want the dropdowns to be.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="MenuDropdownColor" onchange="submit();" style="width:180">
					<option value= "<%=MenuDropdownColor%>" selected><%=MenuDropdownColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Menu Dropdown Mouseover Color:</b><span class="custom info"><em>Menu Dropdown Mouseover Color</em>If you are using a landscape layout style then your menu uses dropdown menus. You can set what color that you want the dropdowns to be when users move their over mouse over them .</span></a>

		</td>
		<td align = "left">
			<select size="1" name="MenuDropdownColorMouseover" onchange="submit();" style="width:180">
					<option value= "<%=MenuDropdownColorMouseover %>" selected><%=MenuDropdownColorMouseover %></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	
	
<% end if %>
<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Rounded Menu Corners:</b><span class="custom info"><em>Rounded Menu Corners</em>The corners of your menu can be at rounded or at right angles.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="MenuRoundedCorners" onchange="submit();" style="width:180">
			<% if MenuRoundedCorners = "Yes" or MenuRoundedCorners = "True" then %>
					<option value="Yes" >Yes</option>	
					<option  value="No" >No</option>
			<% else %>
				<option  value="No" >No</option>
				<option value="Yes" >Yes</option>	
			<% end if %>
			</select>
		</td>
	</tr>
	
	<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Menu Shadows:</b><span class="custom info"><em>Menu Shadows</em>Your menu can have a shadow.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="MenuShadow" onchange="submit();" style="width:180">
			<% if MenuShadow = "Yes" or MenuShadow = "True" then %>
					<option value="Yes" >Yes</option>	
					<option  value="No" >No</option>
			<% else %>
				<option  value="No" >No</option>
				<option value="Yes" >Yes</option>	
			<% end if %>
			</select>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
				<b>Footer</b>
				
		</td>
		<td align = "left">
			
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
		<a class="tooltip" href="#"><b>Footer Background Color:</b><span class="custom info"><em>Footer Background Color</em>This color is seen behind your footer links, unless you have uploaded a Footer Background Image. To upload a Footer Background Image go to the bottom of this page.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="FooterColor" onchange="submit();" style="width:180">
					<option value= "<%=FooterColor%>" selected><%=FooterColor%></option>
						<!--#Include file="AdminColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Rounded Footer Corners:</b><span class="custom info"><em>Rounded Footer Corners</em>The corners of your footer can be at rounded or at right angles.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="FooterRoundedCorners" onchange="submit();" style="width:180">
			<% if FooterRoundedCorners = "Yes" or FooterRoundedCorners = "True" then %>
					<option value="Yes" >Yes</option>	
					<option  value="No" >No</option>
			<% else %>
				<option  value="No" >No</option>
				<option value="Yes" >Yes</option>	
			<% end if %>
			</select>
		</td>
	</tr>
	
	<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Footer Shadows:</b><span class="custom info"><em>Footer Shadows</em>Your footer can have a shadow.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="FooterShadow" onchange="submit();" style="width:180">
			<% if MenuShadow = "Yes" or FooterShadow = "True" then %>
					<option value="Yes" >Yes</option>	
					<option  value="No" >No</option>
			<% else %>
				<option  value="No" >No</option>
				<option value="Yes" >Yes</option>	
			<% end if %>
			</select>
		</td>
	</tr>
	
	<tr>
		<td class = "body" align = "right">
				<b>Pictures</b>
				
		</td>
		<td align = "left">
			
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Picture Border:</b><span class="custom info"><em>Picture Border</em>Do you want a border around your pictures?</span></a>

		</td>
		<td align = "left">
			<select size="1" name="PicturesBorder" onchange="submit();" style="width:180">
			<% if PicturesBorder = "Yes" or PicturesBorder = "True" then %>
					<option value="Yes" >Yes</option>	
					<option  value="No" >No</option>
			<% else %>
				<option  value="No" >No</option>
				<option value="Yes" >Yes</option>	
			<% end if %>
			</select>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			<a class="tooltip" href="#"><b>Pictures Border Size:</b><span class="custom info"><em>Pictures Border Size</em>Would you like a border around the pictures on your pages? If not then select 0 pixels, otherwise select the width of your border - 1, 2, or 3 pixels.</span></a>
	</td>
		<td align = "left">
			<select size="1" name="PicturesBorderSize" onchange="submit();" style="width:180">
					<option value= "<%=PicturesBorderSize%>" selected><%=PicturesBorderSize%> pixel(s)</option>
						<option value= "0" >0 - No Border</option>
						<option value= "1" >1 pixel</option>
						<option value= "2" >2 pixels</option>
						<option value= "3" >3 pixels</option>
					</select>
		</td>
	</tr>
	<% if PicturesBorderSize > 0 then %>
<tr>
		<td class = "body" align = "right" >
		<a class="tooltip" href="#"><b>Pictures Border Color:</b><span class="custom info"><em>Pictures Border Color</em>If you picked a picture border, then pick a color.</span></a>
		
		</td>
		<td align = "left">
			<select size="1" name="PicturesBorderColor" onchange="submit();" style="width:180">
					<option value= "<%=PicturesBorderColor%>" selected><%=PicturesBorderColor%></option>
					<!--#Include file="AdminColorOptionsInclude.asp"--> 		
					</select>
		</td>
	</tr>
<% end if %>

	
	<tr>
		<td class = "body" align = "right">
						<a class="tooltip" href="#"><b>Picture Shadows:</b><span class="custom info"><em>Picture Shadows</em>Your pictures can have a shadow.</span></a>

		</td>
		<td align = "left">
			<select size="1" name="PicturesShadow" onchange="submit();" style="width:180">
			<% if PicturesShadow = "Yes" or PicturesShadow = "True" then %>
					<option value="Yes" >Yes</option>	
					<option  value="No" >No</option>
			<% else %>
				<option  value="No" >No</option>
				<option value="Yes" >Yes</option>	
			<% end if %>
			</select>
		</td>
	</tr>
	
	

</table>	
<br /><br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
 <tr>
	<td class ="body" colspan = "2" >
		<h2>Layout Styles</h2>
	</td>
</tr>
 <tr>
	<td class ="body" colspan = "2" >
		<img src = "images/layoutstyles.jpg" width ="330" height = "150">
	</td>
</tr>
		
</table>
   
        </td>
        </tr>
       </table>
     </td>
     <td width= "480" valign = "top">
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Design Preview</div></H2
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "460">
       <a name = "preview"></a>
			Below is a rough approximation of your site to show your design, with no text or links. Everything is at 30% it's final size.<br><br>
   <br>
<center>
        
        	<iframe src ="AdminFrameDesign.asp" width="460" height="380"  frameborder = "0" scrolling = "no" >
			 <p>Your browser does not support iframes.</p>
			</iframe>
			</center>
        </td>
        </tr>
       </table>
    </td>
 </tr>
</table>
 </Body>
</HTML>
