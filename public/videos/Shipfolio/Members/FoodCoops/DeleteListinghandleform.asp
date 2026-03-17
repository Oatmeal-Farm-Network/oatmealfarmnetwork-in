<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Livestock of AmericaAdministration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="Products"
Current3="ProductDelete" %> 
<!--#Include file="adminHeader.asp"-->
<!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "940"><tr><td class = "roundedtopandbottom" align = "left"><br />
<H1><div align = "left">Delete a Product</div></H1>
<br />
<%
dim ID
ID=Request.Form("ID" ) 
Query =  "Delete * From sfProducts where prodID = " &  ID & "" 
Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing %>
<!--#Include virtual="/ConnStats.asp"-->

<%
Query =  "Delete * From ProductStats where prodID = " &  ID & "" 
Connstats.Execute(Query) 

Connstats.Close
Set Connstats = Nothing %>

<div align = "center"><H2>
<% response.write("The Listing has successfully been deleted.") %></H2>
<br><a  class = "body2" href="DeleteListing.asp">Click here to return to the delete Products page.</a>
<br><br><br></td></tr></table>
</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</Body>
</HTML>