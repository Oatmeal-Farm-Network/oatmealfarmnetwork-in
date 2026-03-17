<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="style.css">

<!--#Include file="MembersGlobalvariables.asp"--> 
<% 
ProdID=request.form("ProdID") 
If Len(ProdID) < 3 then
ProdID= Request.QueryString("ProdID") 
End If
Session("ProdID") = ProdID %>
</head>
<body >
<% Current3 = "EditProduct" %>
<!--#Include file="MembersHeader.asp"--> 
<% Dim IDArray2(1000)
Dim Prodname2(10000)
Dim AdType(10000)

 If Len(ProdID) = 0 Then 
sql2 = "select * from sfProducts order by Prodname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("prodID")
		Prodname2(acounter) = rs2("Prodname")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
 %> 
 <!--#Include file="MembersProductsTabsInclude.asp"-->
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Your Product<br>Step 1: Select a Product</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960"  height = "200" valign = "top">
        
        
<table border = "0" width = "800"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >

<form action="MembersAdEdit2.asp" method = "post">
		
			   <tr>
				<td width ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your listings:<br>
					<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=Prodname2(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "regsubmit2" >
</td></tr></table></form>
</td></tr></table>
<% Else %>
<!-- #include file="MembersProductsPhotoFormInclude2.asp" -->
<% End if %>
</td>
</tr>
</table>
<br>
<!-- #include file="MembersFooter.asp" -->
</Body>
</HTML>
