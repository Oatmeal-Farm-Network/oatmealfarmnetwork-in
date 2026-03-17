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
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "DeleteProduct" %> 
<!--#Include file="AdminHeader.asp"-->
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>" >
<tr><td class = "body roundedtop" align = "left" valign = "top">
<H1><div align = "left">Delete Products</div></H1>
</td></tr>
<tr><td class = "body roundedBottom">
<% conn.close
set conn = nothing %>
<!--#Include virtual="/connloa.asp"-->

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
rs2.Open sql2, connloa, 3, 3 
if not rs2.eof then 
    	
    ProdName= rs2("ProdName")
    ProdDescription= rs2("ProdDescription")
ProdPrice  = rs2("ProdPrice")


rs2.close
sql = "select * from ProductsPhotos where id = " & ID
'response.write("sql=" & sql )
rs2.Open sql, connloa, 3, 3
If not rs2.eof Then
Photo1 = rs2("ProductImage1")
 'response.write("Photo1=" & Photo1 )
end if


rs2.close
set rs2=nothing
set connloa = nothing
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" >
<tr>
	<td class = "body2" valign = "top" align = "center" colspan = 2>
	<br /><b>Are you sure that you want to delete this product?
 Once a product listing is deleted, it's gone!</b><br><br>
	</td>
</tr>
<tr>
    <td>
     <% if len(Photo1)> 4 then %>
    <img src = "<%=Photo1 %>" width = 160 align = center />
    <% end if %>
    </td>
    <td class = body valign = top>		
			<form action= 'membersDeleteListinghandleform.asp' method = "post">
				<input type = "hidden" name="ID" value= "<%=ID %>">
               

			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "right" class = body2 >Product Name:</td>
                 <td width = "10">&nbsp;</td>
                 <td class = body><b><%=ProdName%></b></td>
                </tr>


                <% if len(ProdDescription) > 3 then%>
                 <tr>
				 <td align = "right" class = body2>Description:</td>
                 <td width = "10">&nbsp;</td>
                 <td  class = body><%=ProdDescription%></b></td>
                </tr>
                <% end if %>

				<td colspan = 3 align = center>
                <br />
					<input type=submit value = "Delete"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
   </td>
   </tr>
   </table>


		  </form>
 <% End If %>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>