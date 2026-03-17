<!DOCTYPE HTML>
<HTML>
<HEAD>
 <!--#Include file="AdminGlobalVariables.asp"--> 
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
   <!--#Include file="AdminHeader.asp"-->
<br />
<% Current3 = "DeleteProducts" %>
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
ID=Request.Form("ID")
 
Found = false
sql2 = "select LOAProductID from sfProducts where prodID =  " & ID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof  then
LOAProductID = rs2("LOAProductID")
end if
rs2.close

if rs.state> 0 then
rs.close
end if
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/ConnLOA.asp"-->
<% 
if len(trim(LOAProductID )) > 0 then					
sql = "select ProdID from sfproducts where prodID= " &  LOAProductID 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3  
If (Not rs.eof) and len(trim(LOAProductID)) > 0 Then
Found = True
End if		 
rs.close
end if


if Found = True then
Query =  "Delete From sfProducts where prodID = " &  LOAProductID & "" 
ConnLOA.Execute(Query) 

Query =  "Delete From productCategoriesList where ProductID = " &  LOAProductID & "" 
ConnLOA.Execute(Query) 
	
Query =  "Delete From productColor where ProductID = " &  LOAProductID & "" 
ConnLOA.Execute(Query) 
	
Query =  "Delete From productsPhotos where ID = " &  LOAProductID & "" 
ConnLOA.Execute(Query) 
	
Query =  "Delete From productSizes where ProductID = " & LOAProductID & "" 
ConnLOA.Execute(Query) 
end if %>

<!--#Include virtual="/Conn.asp"-->

<%
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
%>
<div align = "center"><H2>
<%
     response.write("The Listing has Successfully Been deleted.")
  %></H2>

<%
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
