<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="Membersglobalvariables.asp"-->



<% 
sql = "select * from People where PeopleID = " & PeopleID
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
 if not rs.eof then
Header = rs("Header")

str1 = lcase(Header ) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Header =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

logo = rs("Logo")
str1 = lcase(Logo) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

RanchHomeText = rs("RanchHomeText")
RanchHomeImage1= rs("RanchHomeImage1")
str1 = lcase(RanchHomeImage1) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
RanchHomeImage1=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
ScreenBackground=rs("ScreenBackground")
str1 = lcase(ScreenBackground) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
ScreenBackground=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
end if

AddDesign = False
  sql = "select * from RanchSiteDesign where PeopleID = " & PeopleID
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
 if rs.eof then
    AddDesign = true
 end if
 rs.close
    
if AddDesign = true then
    	Query =  "INSERT INTO RanchSiteDesign (PeopleID)" 
		Query =  Query & " Values (" &  PeopleID  & ")"
		Conn.Execute(Query) 

end if
 sql = "select * from RanchSiteDesign where PeopleID = " & PeopleID
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
 if not rs.eof then
PageBackgroundColor= rs("PageBackgroundColor")
MenuBackgroundColor= rs("MenuBackgroundColor")
end if
rs.close	

UPdateColors=request.QueryString("UPdateColors")

if UPdateColors="True" then
MenuBackgroundColor = request.form("MenuBackgroundColor")
PageBackgroundColor  = request.form("PageBackgroundColor")

Query =  " UPDATE RanchSiteDesign Set LayoutStyle = '" & LayoutStyle & "', "
Query =  Query & " MenuBackgroundColor = '" & MenuBackgroundColor & "' ,"
Query =  Query & " PageBackgroundColor = '" & PageBackgroundColor & "'  "
Query =  Query & " where PeopleID = " & PeopleID 
Conn.Execute(Query) 

end if
%>

</HEAD>
<body >

<!--#Include file="MembersHeader.asp"-->

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -90%>"><tr><td align = "left">
<H1><div align = "left">Ranch Pages Design</div></H1>
<a name="Top"></a>

<table border = "0"  width = "100%">
<tr>
  <td colspan = "2">
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" class = "formbox"><tr><td align = "left">
		<H2><div align = "left">Images</div></H2>
</td></tr>
<tr><td >
<div align = "left" class = "body">Images must be in .JPG, .JPEG, .GIF, or .PNG format and less than 300KB in size.</b></div><br>

<table width = "100%" cellpadding = "5" cellspacing = "5" border = "0" align = "center">
<tr><td width = "185" valign = "top">
<h3>Header Banner</h3>
		
		<% If Len(Header) > 1 then%>
		<img src = "<%= Header%>" height = "45">
		<% End If %>
	</td>
	<td class = "body"  width = "600" valign = "top" >

			<% If Header = "https://www.livestockoftheworld.com/uploads/ImageNotAvailable.jpg" Then %>
				<b>Upload an Image</b><br />
            <% else %>
            <b>Upload a New Image</b><br />
			<% End If %>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersuploadHeaderhandle2.asp?PeopleID=<%=Session("PeopleID")%>" class = "formbox" >
			<input name="attach1" type="file" size=60 >
			<input  type=submit value="UPLOAD" class = "regsubmit2">
			</form>
		</td>
		<td align= "left"  valign = "top"><% If Len(Header) > 1 then%><form action= 'membersRemoveHeader2.asp?PeopleID=<%=Session("PeopleID")%>' method = "post">
			<input type = "hidden" name="ImageID" value= "1" >
			<input type = "hidden" name="ID" value= "<%= ID %>" >
			<center><input type=submit value="REMOVE BANNER" class = "regsubmit2"></center>
			</form><% end if %></td>
</tr>
<tr>
    <td width = "185" valign = "top">
		 
		<h3><a class="tooltip" href="#">Screen Background<span class="custom info body"><div align = "left"><em>Screen Background:</em>Make a big impact by adding a large image that while appear behind your farm pages. All viewers with screen resolutions wider than 1000 pixels will see your screen background image.<B>Image will be automatically be resized to 1900px width by 900px height.</div></b></span></a></h3>
		
		<% If Len(ScreenBackground) > 1 then%>
		<img src = "<%= ScreenBackground%>" height = "45">
		<% End If %>
	</td>
	<td class = "body"  width = "600" valign = "top">
			
			<% If Header = "ImageNotAvailable.jpg" Then %>
				<b>Upload an Image</b><br />
            <% else %>
            <b>Upload a New Image</b><br />
			<% End If %>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersuploadScreenBackgroundHandle2.asp?PeopleID=<%=Session("PeopleID")%>" class = "formbox">
			<input name="attach1" type="file" size=60 >
			<input  type=submit value="UPLOAD" class = "regsubmit2">
			</form>
		</td>
		<td align= "left"  valign = "top"><% If Len(ScreenBackground) > 1 then%><form action= 'membersRemoveScreenBackground2.asp?PeopleID=<%=Session("PeopleID")%>' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="REMOVE BACKGROUND" class = "regsubmit2"></center>
							</form><% end if %></td>
	</tr>
<tr><td width = "185" valign = "top" valign = "top">
			 <a name = "images">
			 	<h3><a class="tooltip" href="#">Logo<span class="custom info body"><div align = "left"><em>Logo:</em>Your logo will show up on your farm pages and across <%=currentwebsite%> where people view your products, animals, and more. <B>Your logo will be automatically be resized to 180 pixels width in most cases.</div></b></span></a></h3>
				<% If Len(logo) > 1 and Len(logo) < 131 then%>
				<img src = "<%= logo%>" width ="180">
			<% End If %>
								 
	</td><td class = "body" width = "600" valign = "top">
	
						
		<% If Logo = "ImageNotAvailable.jpg" Then %>
			<b>Upload an Image</b><br />
            <% else %>
            <b>Upload a New Image</b><br />
			<% End If %>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="membersuploadLogohandle2.asp?PeopleID=<%=Session("PeopleID")%>" class = "formbox" >
		<input name="attach1" type="file" size=60 >
		<input  type=submit value="UPLOAD" class = "regsubmit2"></form>
	</td>
		<td align= "left"  valign = "top">
		<% If Len(logo) > 1 then%>
			<form action= 'membersRemoveLogo2.asp?PeopleID=<%=Session("PeopleID")%>' method = "post">
			<input type = "hidden" name="ImageID" value= "1" >
			<input type = "hidden" name="ID" value= "<%= ID %>" >
			<center><input type=submit value="REMOVE LOGO" class = "regsubmit2"></center>
			</form>
	<% end if %> &nbsp;
		</td>	
			</tr>
	
</table>
   </td>
</tr>
</table>  
  </td>
</tr>
<tr>
<tr>
<td align = "center" valign = "top" width = "500">
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "500">
  <tr><td  align = "center" class ="body formbox">
<H2>Font Styles</H2>
Define below the font styles for your farm pages.
<iframe src ="MembersStyleFonts.asp?PeopleID=<%=PeopleID %>" width="444" height="600" align = "center" frameborder = "0" scrolling = "no" >

<p>Your browser does not support iframes. </p>
</iframe>
</td></tr></table>    
</td><td align = "center" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "body roundedtopandbottom" align = "center"><a name = "PageColors"></a>
<H1>Page Colors</H1>
Define below the background colors for your farm pages.
<form action= "MembersSiteDesign.asp?UPdateColors=True#PageColors" method = "post">	 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "400">
<tr><td class = "body" align = "right"><a class="tooltip" href="#"><b>Headings Background Color</b><span class="custom info"><em>Headings Background Color:</em>This color is seen behind your your table headings.</span></a>
</td>
<td>
<select size="1" name="MenuBackgroundColor" class = "formbox">
<option value= "<%=MenuBackgroundColor%>" selected><%=MenuBackgroundColor%></option>
<!--#Include file="membersColorOptionsInclude.asp"--> 		
</select>
</td></tr>

<tr><td class = "body" align = "right"><a class="tooltip" href="#"><b>Page Background Color:</b><span class="custom info"><em>Page Background Color</em>This color is seen in the body of your pages.</span></a>
</td><td >

<select size="1" name="PageBackgroundColor" class = "formbox"  >
<option value= "<%=PageBackgroundColor%>" selected><%=PageBackgroundColor%></option>
<!--#Include file="membersColorOptionsInclude.asp"--> 		
</select>
</td></tr>

<tr><td class = "small" align = "center" colspan = "2">
<br />
<input type=submit value="SUBMIT" class = "regsubmit2">
<br />
</td></tr></table>	
</form>
 </td></tr></table>
<br />
</td>
</tr>
</table>
<br>
<br><!-- #include File="membersFooter.asp" -->
 </Body>
</HTML>
