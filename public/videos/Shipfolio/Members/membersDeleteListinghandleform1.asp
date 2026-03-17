<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>
<body >

<!--#Include file="membersGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "DeleteProduct" 
Current3 = "Delete"%> 
<!--#Include file="membersHeader.asp"-->
<!--#Include file="MembersProductJumpLinks2.asp"-->
<div class ="container roundedtopandbottom">
  <div class = "row">
    <div class = "col-12" align = "left" valign = "top">
        <H1>Delete Products</H1>
    </div>
  </div>
<%  
ID = request.form("ID")
if len(ID) > 0 then
else
ID = request.querystring("ID")
end if
if len(ID) > 0 then
else
response.redirect("membersDeleteListing.asp")
end if

sql2 = "select * from sfProducts where ProdID = " & ID & " order by Prodname "

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then 
    	
    ProdName= rs2("ProdName")
    ProdDescription= rs2("ProdDescription")
ProdPrice  = rs2("ProdPrice")


rs2.close
sql = "select * from ProductsPhotos where id = " & ID
'response.write("sql=" & sql )
rs2.Open sql, conn, 3, 3
If not rs2.eof Then
Photo1 = rs2("ProductImage1")
 'response.write("Photo1=" & Photo1 )
end if


rs2.close
set rs2=nothing
set connloa = nothing
%>
<div class = "row">
    <div class = "col-12">
	<center><b>Are you sure that you want to delete this product?<br>
        Once a product listing is deleted, it's gone!</b><br></center><br>
	</div>
</div>

<form action= 'membersDeleteListinghandleform.asp' method = "post">
<input type = "hidden" name="ID" value= "<%=ID %>">

<div class = "row">
    <div class = "col-4" align = right>
         <% if len(Photo1)> 4 then %>
             <div align = "right"><img src = "<%=Photo1 %>" width = 160 align = right /></div>
        <% end if %>
     </div>
    <div class = "col-2" align = right>
        Product Name:<br />
        Description:
    </div>
    <div class = "col-4"><%=ProdName%><br />
    <%=ProdDescription%></b>
    </div>
</div>


<div class = "row">
  <div class = "col-12" align = center><br />
	<input type=submit value = "Delete"  class = "roundedtopandbottomyellow" >
  </div>
</div>

</form>
 <% End If %>
 <br /><br />
</div>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>