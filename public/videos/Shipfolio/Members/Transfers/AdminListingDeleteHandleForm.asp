<!DOCTYPE HTML>
<HTML>
<HEAD>
 <!--#Include file="AdminGlobalVariables.asp"--> 
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
   <!--#Include file="AdminHeader.asp"-->
     <% Current3 = "DeleteProducts" %>
     <br />
<!--#Include file="AdminProductsTabsInclude.asp"--> 
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Product</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >   
<table height = "300" align = "center">
	<tr>
		<td class = "body" align = "center" valign = "top">
<br><br><br>
<%

dim ID

	ID=Request.Form("ID" ) 

	Dim DataConnection, cmdDC, RecordSet
	Dim RecordToEdit, Updated
	Set DataConnection = Server.CreateObject("ADODB.Connection")

	

	Query =  "Delete * From sfProducts where prodID = " &  ID & "" 
	Conn.Execute(Query) 

	Query =  "Delete * From productCategoriesList where ProductID = " &  ID & "" 
	Conn.Execute(Query) 
	
Query =  "Delete * From productColor where ProductID = " &  ID & "" 
	Conn.Execute(Query) 
	
	Query =  "Delete * From productsPhotos where ID = " &  ID & "" 
	Conn.Execute(Query) 
	
		Query =  "Delete * From productSizes where ProductID = " &  ID & "" 
	Conn.Execute(Query) 
	
IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("The Listing has Successfully Been deleted.")
  %></H2>

<%

 End If

	Conn.Close
	Set Conn = Nothing 

%>


			<br><a  class = "Links" href="AdminListingDelete.asp">Click here to return to the delete products page.</a>
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
