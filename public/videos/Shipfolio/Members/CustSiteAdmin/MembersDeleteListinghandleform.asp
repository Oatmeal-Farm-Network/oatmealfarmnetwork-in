<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="adminGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "DeleteProduct" %> 
<!--#Include file="adminHeader.asp"-->
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td  align = "left" class = "roundedtop">
<H1><div align = "left">Delete a Product</div></H1>
</td></tr>
<tr><td class = "roundedBottom">
<br />
<% conn.close
set conn = nothing %>

<!--#Include virtual="/Connloa.asp"-->
<%
dim ID
ID=Request.Form("ID" )

if len(ID) > 0 then
Query =  "Delete From sfProducts where prodID = " &  ID & "" 
connloa.Execute(Query) 

connloa.Close
Set connloa = Nothing %>
<!--#Include virtual="/Connloa.asp"-->

<% 

Query =  "Delete From productCategoriesList where productID = " &  ID & "" 
connloa.Execute(Query) 

Query =  "Delete From ProductStats where prodID = " &  ID & "" 
connloa.Execute(Query) 

end if

connloa.Close
Set connloa = Nothing %>

<div align = "center"><H2>
<% response.write("The Listing has successfully been deleted.") %></H2>
<br><a  class = "body2" href="membersDeleteListing.asp">Click here to return to the delete Products page.</a>
<br><br><br></td></tr></table>
</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</Body>
</HTML>