<!DOCTYPE HTML>
<HTML>
<HEAD>
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
    
    <!--#Include file="AdminSecurityInclude.asp"-->
    <!--#Include file="AdminGlobalVariables.asp"--> 
   <!--#Include file="AdminHeader.asp"-->
<% Current3 = "DeleteServices" %> 
<!--#Include file="AdminPagesTabsInclude.asp"-->
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Page</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >   
<table height = "300" align = "center">
	<tr>
		<td class = "body" align = "center" valign = "top">
        <br><br><br>
<%

dim ServiceTitle

ServiceTitle=Request.Form("ServiceTitle" ) 
PageType=Request.Form("PageType" ) 
PageLayoutID=Request.Form("PageLayoutID") 
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

if PageType = "Service" then
Query =  "Delete * From Services where PagelayoutID = " &  PagelayoutID & "" 
DataConnection.Execute(Query) 
end if

if len(PageLayoutID) > 0 then
	Query =  "Delete * From PageLayout where PageLayoutID = " &  PageLayoutID & "" 
	DataConnection.Execute(Query) 

	Query =  "Delete * From PageLayout2 where PageLayoutID = " &  PageLayoutID & "" 
	DataConnection.Execute(Query) 
	
end if
 %>
<div align = "center"><H2>
<%
     response.write("The page has successfully been deleted.")
  %></H2>

<%
	DataConnection.Close
	Set DataConnection = Nothing 
%>
	<br><a  class = "Links" href="AdminpageDeleteList.asp">Delete another page.</a><br />
			<br><a  class = "Links" href="Default.asp">Click here to return to the AGCMS home page.</a>
			<br>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<br />
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>
