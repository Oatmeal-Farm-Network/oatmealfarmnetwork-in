<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">

<% dim	IDArray(9999) 
dim	alpacaName(9999)
PagelayoutID =Request.Querystring("PagelayoutID" ) 
If Len(PagelayoutID) = 0 then
	PagelayoutID=Request.Form("PagelayoutID") 
End If

 
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
if len(ID) < 1 then
else
ID = Session("ID")
end if

If len(ID) > 0 then
Session("ID") = ID
end if
%>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ID=<%=ID %>');">
<% end if %>
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="AlpacasHome"
Current3 = "Preview"  %>
<% Current3 = "PageContent" %>
<!--#Include File="AdminHeader.asp"-->
<% if mobiledevice = False  then %>

<% if PageName = "Farm Store" then 
Current3 = "Preview" %>
<!--#Include file="AdminProductsTabsInclude.asp"-->
<% else 
Current3 = "Preview" %>
<!--#Include file="AdminPagesTabsInclude.asp"-->
<% end if %>
<% end if %> 
<%  If Len(ID) > 0 then
 %>
   <!--#Include virtual="/DetailDBInclude.asp"--> 
 
<% end if


If Len(ID) > 0 then
	 sql2 = "select * from Photos where ID = " &  ID & ";" 
	'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3   
	 If rs2.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
DataConnection.Execute(Query) 
DataConnection.Close
Set DataConnection = Nothing 
	End If 
End if

	
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if rs2.eof then %>

<% 
if screenwidth < 989 then %>
<table border = "1" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit a Listing</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" >
        Currently you do not have any alpacas entered. To add alpacas please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.
        </td>
        </tr>
        </table>
        
<%	else
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

 If Len(ID) = 0 Then %>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = "<%= screenwidth %>">
 <tr><td class = "roundedtop" align = "left">
<H2>Edit An Animal Listing</H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left" valign = "top" width = "100%">
			<form  action="AdminAnimalPreview.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top">
			   <tr>
				<td colspan ="10">
					&nbsp;
				</td>
				 <td class = "body" >
					<br>Select one of your animals:
					<select size="1" name="ID" class = "regsubmit2 body">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<input type=submit Value = "Submit" class = "regsubmit2 body" >
				</td>
			  </tr>
		    </table>
		  </form>
</td>
</tr>
<tr><td></td></tr>
</table>
<% else  
screenwidth = screenwidth - 50
%>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = "100%">
 <tr><td class = "roundedtop" align = "right">
		<H2>Edit Another Animal Listing</H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left" valign = "top" >
			<form  action="AdminAnimalPreview.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top">
			   <tr>
				<td colspan ="10">
					&nbsp;
				</td>
				 <td class = "body" >
					<br>Select one of your animals:
					<select size="1" name="ID" class = "regsubmit2 body">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<input type=submit Value = "Submit" class = "regsubmit2 body" >
				</td>
			  </tr>
		    </table>
		  </form>
<i>Note: links and buttons are disabled in the preview below:</i>
<iframe src ="AdminAnimalPreviewframe.asp?ID=<%=ID %>&screenwidth=<%=screenwidth %>&DetailType=Dam" width="<%=screenwidth %>" height="1780" frameborder = "0" scrolling = "no" style="background-color:white" align = "center" class = "roundedtopandbottom">
<p>Your browser does not support iframes.</p>
</iframe>



<% End if %>
<% End if %>
</td>
</tr>
</table><br><br><br><br>
<!--#Include file="adminFooter.asp"-->

 </Body>
</HTML>

