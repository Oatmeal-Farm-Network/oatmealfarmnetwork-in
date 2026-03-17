<!doctype html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<% Page = "Editwebsite"  %>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >
<!--#Include file="AdminHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
<tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Website Layout & Images</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth %>">
<%  PageName = "layout" %> 
<!--#Include file="AdminLayoutHeader.asp"--> 
<% 
PeopleID = session("PeopleID")
sql = "select * from SiteDesign where Peopleid=667"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
PeopleID = rs("PeopleID")
rs.close

sql = "select * from people where Peopleid=667"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
FavIcon= rs("FavIcon")
rs.close

sql = "select * from SiteDesigntemp where PeopleID=667 "
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
Header = rs("Header")
logo = rs("Logo")
PicturesBorder = rs("PicturesBorder")
PicturesBorderSize = rs("PicturesBorderSize")
PicturesBorderColor = rs("PicturesBorderSize")
PicturesShadow = rs("PicturesShadow")
PagebackgroundImage = rs("PagebackgroundImage")
MenuBackgroundImage = rs("MenuBackgroundImage")
MenuDropdownColor = rs("MenuDropdownColor")
MenuShadow = rs("MenuShadow")
MenuRoundedCorners = rs("MenuRoundedCorners")
FooterImage = rs("FooterImage")
FooterShadow = rs("FooterShadow")
FooterRoundedCorners = rs("FooterRoundedCorners")
ScreenBackgroundImage = rs("ScreenBackgroundImage")
NonRepeatingScreenBackgroundImage= rs("NonRepeatingScreenBackgroundImage")
DBPagewidth = rs("Pagewidth")
DBPageAlign = rs("PageAlign")
DBLayoutStyle = rs("LayoutStyle")
DBScreenBackgroundColor = rs("ScreenBackgroundColor")
DBNonRepeatingScreenBackgroundImage = rs("NonRepeatingScreenBackgroundImage")
DBPicturesBorder = rs("PicturesBorder")
DBPicturesBorderSize = rs("PicturesBorderSize")
DBPicturesBorderColor = rs("PicturesBorderSize")
DBPicturesShadow = rs("PicturesShadow")
DBPageBorder = rs("PageBorder")
DBPageBorderColor = rs("PageBorderColor")
DBMenuBackgroundColor = rs("MenuBackgroundColor")
DBPageBackgroundColor = rs("PageBackgroundColor")
DBMenuDropdownColor = rs("MenuDropdownColor")
DBMenuDropdownColorMouseover = rs("MenuDropdownColorMouseover")
DBMenuShadow = rs("MenuShadow")
DBMenuRoundedCorners = rs("MenuRoundedCorners")
DBFooterShadow = rs("FooterShadow")
DBFooterRoundedCorners = rs("FooterRoundedCorners")
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
NonRepeatingScreenBackgroundImage=Request.Form("NonRepeatingScreenBackgroundImage" ) 
If Len(NonRepeatingScreenBackgroundImage) > 1  then
Else
NonRepeatingScreenBackgroundImage = DBNonRepeatingScreenBackgroundImage
End If
PageBorder=Request.Form("PageBorder" ) 
If Len(PageBorder) > 1  then
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
MenuDropdownColorMouseover=Request.Form("MenuDropdownColorMouseover" ) 
If Len(MenuDropdownColorMouseover) > 1  then
Else
MenuDropdownColorMouseover = DBMenuDropdownColorMouseover
End If
PageBackgroundColor=Request.Form("PageBackgroundColor" ) 
If Len(PageBackgroundColor) > 1  then
Else
PageBackgroundColor = DBPageBackgroundColor
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
Query =  " UPDATE SiteDesigntemp Set PageWidth = " & PageWidth & ","
Query =  Query & " LayoutStyle = '" & LayoutStyle & "', "
Query =  Query & " ScreenBackgroundColor = '" & ScreenBackgroundColor & "' ,"
Query =  Query & " NonRepeatingScreenBackgroundImage = '" & NonRepeatingScreenBackgroundImage & "' ,"
Query =  Query & "  PageBorder = '" & PageBorder & "' ,"
Query =  Query & " PageAlign = '" & PageAlign & "' ,"
Query =  Query & "  PageBorderColor = '" & PageBorderColor & "' ,"
Query =  Query & " MenuBackgroundColor = '" & MenuBackgroundColor & "' ,"
Query =  Query & " MenuDropdownColor = '" & MenuDropdownColor & "' ,"
Query =  Query & " MenuDropdownColorMouseover = '" & MenuDropdownColorMouseover & "' ,"
Query =  Query & " MenuShadow = '" & MenuShadow & "' ,"
Query =  Query & " MenuRoundedCorners= '" & MenuRoundedCorners & "' ,"
Query =  Query & " FooterShadow = '" & FooterShadow & "' ,"
Query =  Query & " FooterRoundedCorners= '" & FooterRoundedCorners & "' ,"
Query =  Query & " PicturesBorder= " & PicturesBorder & " ,"
Query =  Query & " PicturesBorderSize= '" & PicturesBorderSize & "' ,"
Query =  Query & " PicturesBorderColor= '" &PicturesBorderColor & "' ,"
Query =  Query & " PicturesShadow= '" & PicturesShadow & "' ,"
Query =  Query & " PageBackgroundColor = '" & PageBackgroundColor & "' "
Query =  Query & " where PeopleID = 667" 
'response.write(Query)	
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Close
pagename = "layout"
%>
<br />
<iframe src ="AdminStandardStyles.asp" width="100%" height="750" frameborder = "0" scrolling = "no" valign = "top" align = "center" style="background-color:white">
<p>Your browser does not support iframes.</p>
</iframe>
<table width = "970" border = "0" cellpadding = "0" cellspacing = "0">
<tr>
<td width = "482" valign = "top">
   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Favicon</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "460">
<table><tr><td>
<% If Len(FavIcon) > 1 then%>
<img src = "<%= Favicon%>" >
<% End If %>
</td></tr>
<tr><td class = "body"  >
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageUploadFaviconHandle.asp" >
<% If Favicon = "ImageNotAvailable.jpg" Then %>
Current Fav Icon Image Name : Not Defined<br>
<% End If %>
Upload Page FavIcon Image: 
<input name="attach1" type="file" size=45 /><br>
<center><input  type="submit" value="Upload" class = "regsubmit2"></center>
</form>
</td>
</tr>

<tr>
<td  >
<% If Len(Favicon) > 1 then%>
<form action= 'AdminPageRemoveBackground.asp' method = "post">
<input type = "hidden" name="ImageID" value= "1" >
<input type = "hidden" name="ID" value= "<%= ID %>" >
<center><input type=submit value="Remove"class = "regsubmit2"></center>
</form>
<% end if %>
</td></tr></table>
</td></tr></table>

<br>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
<tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Your Logo</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "460">	  
<table border = "0"><tr><td>  
<a name = "images">
<% If Len(logo) > 1 then%>
<img src = "<%= logo%>" width = "100">
<% End If %>
</td></tr>
<tr><form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminLogoUploadHandle2.asp" >
					<td class = "body"   >
						Upload Logo: <input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td></tr></form>
<tr>
<td align= "center"  >
<% If Len(logo) > 1 then%>
					<form action= 'AdminLogo2Remove.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove" class = "regsubmit2"></center>
	</form>
	<% end if %>
	</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
	<br />
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Header Image</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460">
        <table border = "0">
        <tr>
        <td>        
								<% If Len(Header) > 1 then%>
									<img src = "<%= Header%>" width = "400">
								<% End If %>
								</td>
				</tr>
				
<tr>

				<td class = "body" >
				<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminHeaderUploadHandle2.asp" >
				
						
						<% If Header = "ImageNotAvailable.jpg" Then %>
								Current Logo Image Name: Not Defined<br>
						<% End If %>

						Upload Header: <input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td>
				</tr>
				</form>
					
				<tr>
					<td  >
					<% If Len(Header) > 1 then%>
					<form action= 'AdminHeader2Remove.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove" class = "regsubmit2"></center>
							</form>
					<% end if %>		
							</td>
	</tr>
	</table>
	</td>
	</tr>
	</table>
<br />
   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Page Background Image <small>(Repeating Texture)</small></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460">
        <table>
          <tr><td>
                <% If Len(PageBackgroundImage) > 1 then%>
									<img src = "<%= PageBackgroundImage%>" width = "300">
								<% End If %>
			</td>
</tr>
<tr>
				<td class = "body"  >
				<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageUploadBackGroundHandle.asp" >
				
						
						<% If PageBackgroundImage = "ImageNotAvailable.jpg" Then %>
								Current Logo Image Name: Not Defined<br>
						<% End If %>

						Upload Page Background Image: 
						
						<input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td>
				</tr>
				</form>
					
				<tr>
					<td  >
					<% If Len(PageBackgroundImage) > 1 then%>
					<form action= 'AdminPageRemoveBackground.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove"class = "regsubmit2"></center>
					</form>
					<% end if %>
</td></tr></table>
</td></tr></table>
<br />

</td>
</td><td width = "6"></td>
       <td width = "482" valign = "top">
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Menu Background Image <small>(Repeating Texture)</small></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460">
        <table>
          <tr><td>	 
<% If Len(MenuBackgroundImage) > 4 and not(trim(MenuBackgroundImage) = "Image Not Defined" ) then %>
		<img src = "<%= MenuBackgroundImage%>" width = "100">
<% End If %>
</td>
</tr>
<tr>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminMenuUploadBackgroundImage.asp" >
					<td class = "body"  >
						
						<% If Logo = "ImageNotAvailable.jpg" Then %>
								Current Image Name: Not Defined<br>
						<% End If %>

						Upload Image: <input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td>
				</tr>
					</form>
					<td align= "center"  >
					<% If Len(MenuBackgroundImage) > 4 and not(trim(MenuBackgroundImage) = "Image Not Defined" ) then %>
					<form action= 'AdminMenuRemoveBackgroundImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove" class = "regsubmit2"></center></form>
				<% end if %>
				</td>	
			</tr>
		</table>
	</td>	
			</tr>
		</table>
		<br />
		     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Footer Background Image <small>(Repeating Texture)</small></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460">
        <table>
        <tr>
			  <td  class = "body"  >

								<% If Len(FooterImage) > 4 and not(trim(FooterImage) = "Image Not Defined" ) then %>
									<img src = "<%= FooterImage%>" width = "100">
								<% End If %>
								 
							</td>
						</tr>
<tr>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminFooterUploadBackgroundImage.asp" >
					<td class = "body"  >
						
						<% If Logo = "ImageNotAvailable.jpg" Then %>
								Current Image Name: Not Defined<br>
						<% End If %>

						Upload Image: <input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td>
				</tr>
					</form>
					<td align= "center"  >
					<% If Len(FooterImage) > 4 and not(trim(FooterImage) = "Image Not Defined" ) then %>
					<form action= 'AdminFooterRemoveBackgroundImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove" class = "regsubmit2"></center>
	</form>
	<%end if  %>
				</td>	
			</tr>
        
        </table>
        </td>
        </tr>
        </table>
        <br />
         <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Repeating Screen Image <small>(Repeating Texture)</small></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460">
        <table>
        <tr>
			  <td  class = "body"  >
								<% If Len(ScreenBackgroundImage) > 4 then%>
									<img src = "<%= ScreenBackgroundImage%>" width = "460">
								<% End If %>
							</td>
				</tr>

				<td class = "body"  >
				<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminScreenUploadBackgroundImage.asp" >
				
						
						<% If ScreenBackgroundImage = "ImageNotAvailable.jpg" Then %>
								Current Image: Not Defined<br>
						<% End If %>

						Upload Image: <input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td>
				</tr>
				</form>
					<tr>
					<td  >
					<% If Len(ScreenBackgroundImage) > 4 then%>
					<form action= 'AdminScreenRemoveBackgroundImage.asp' method = "post">
				
					
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove" class = "regsubmit2"></center></form>
					<% end if %>
				</td>
			</tr>
			</table>
        </td>
        </tr>
        </table>
        <br />
        
        <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Non-Repeating Screen Background Image <br /><small>(1900 pixels by 900 pixels )</small></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "460">
         <table>
        <tr>
			  <td  class = "body" >
								<% If Len(NonRepeatingScreenBackgroundImage) > 4 then%>
									<img src = "<%= NonRepeatingScreenBackgroundImage%>" height = "100">
								<% End If %>
							</td>
				</tr>

				<td class = "body"  >
				<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminUploadNonRepeatingScreenBackgroundImage.asp" >
				
						
						<% If ScreenBackgroundImage = "ImageNotAvailable.jpg" Then %>
								Current Image: Not Defined<br>
						<% End If %>

						Upload Image: <input name="attach1" type="file" size=45 ><br>
						<center><input  type=submit value="Upload" class = "regsubmit2"></center>
					</td>
				</tr>
				</form>
					<tr>
					<td  >
					<% If Len(NonRepeatingScreenBackgroundImage) > 4 then%>
					<form action= 'AdminScreenRemoveNonRepeatingBackgroundImage.asp' method = "post">
				
					
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove" class = "regsubmit2"></center></form>
					<% end if %>
				</td>
			</tr>
			</table>
        </td>
        </tr>
        </table>
        <br />
        
        
     </td>
</tr>
</table>


</td>
</tr>
</table>
<br>	
<!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
