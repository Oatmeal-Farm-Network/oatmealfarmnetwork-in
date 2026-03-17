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
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "ListOfProducts" %> 
<!--#Include file="MembersHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32 %>"><tr><td align = "left">
		<H1><div align = "left">Products</div></H1>
<br />
<table border = "0" width = "<%=screenwidth - 32 %>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body" height = "300">

<%  dim prodID(99999) 
dim prodName(99999)  
dim prodPrice(99999) 
dim ProdForSale(99999) 
dim ProdQuantityAvailable(99999)
dim catName(99999)
dim subcategoryName(99999)
dim catID(99999)
dim PublishProduct(99999)
sql = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if rs.eof then %>
Currently you do not have an products listed. To add products please select the <A href = "PlaceClassifiedAd0.asp" class = "body">Add Products</A> tab above.
<% else
	rowcount = 1


%><br>
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
<td class = "body" width = "80" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0">Edit</td>
<td class = "body" width = "80" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos">Photos</td>
<td class = "body" width = "80" align = "right"><img src = "images/delete.jpg" height = "18" border = "0" alt = "Delete Product">Delete</td>
<td></td>
    
    </tr>
</table>

<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr bgcolor = #e6e6e6 height = 50>
<td class = "body2" align = "center" width = "500"><b>Name</b></td>
<td class = "body2" align = "center" ><b>Published</b></td>
<td class = "body2" align = "center" width = "120" ><b>QTY Available</b></td>
<td class = "body2" align = "center" width = "29" ></td>
<td class = "body2" align = "center" width = "100" ><b>Options</b></td>
	</tr>

<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	prodSubCategoryId = rs("prodSubCategoryId")
	catID(rowcount) =   rs("prodCategoryId")
    if len(prodSubCategoryId) > 0 then 
	sql2 = "select SubCategoryName from sfSubCategories where SubCatId = " & prodSubCategoryId 
    'response.write("sql2=" & sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then  
    	SubcategoryName(rowcount) =   rs2("SubCategoryName")
    else
        SubcategoryName(rowcount) = 0
    end if 
    rs2.close
   end if

if len(catID(rowcount)) > 0 then
sql2 = "select catname from SfCategories where CatId = " & catID(rowcount) 
Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then  
    	catName(rowcount) =   rs2("catName")
    else
        catName(rowcount) = 0
    end if 
    rs2.close

end if
PublishProduct(rowcount) = rs("PublishProduct")
	prodID(rowcount) =   rs("prodID")
	prodName(rowcount) =   rs("prodName")
	prodPrice(rowcount) =   rs("prodPrice")
	ProdForSale(rowcount) =   rs("ProdForSale")
ProdQuantityAvailable(rowcount)  =   rs("ProdQuantityAvailable")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "#e6e6e6" >
<%	End If %>
		

	</td>
	<td class = "body"  align = "left" height = "25">
		<a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body"><%= prodName( rowcount)%></a>
	</td>
    	<td class = "body2" align = "center">
		<% if PublishProduct(rowcount) = 1  then%><center>&#10003;</center><% end if %>
	</td>
	<td class = "body2" align = "center" >
		<%=ProdQuantityAvailable(rowcount) %>
	</td>

			<td class = "body" align = "center"  ></td>	
		<td class = "body" align = "center" ><a href = "MembersAdEdit2.asp?prodID=<%= prodID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "MembersProductPhotos.asp?prodID=<%=prodid( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a>|&nbsp;<a href = "membersDeleteListinghandleform1.asp?ID=<%=prodid( rowcount)%>" class = "body"><img src= "images/delete.jpg" alt = "edit" height ="18" border = "0"></a><br>
		</td>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing

 %>


</table>

<br>

</td>
</tr>
</table>

</td>
</tr>
</table><% end if %>
</td>
</tr>
</table>
<br>
</td>
</tr>
</table>
 <!--#Include file="membersFooter.asp"--> 

</BODY>
</HTML>